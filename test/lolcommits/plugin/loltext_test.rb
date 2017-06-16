require 'test_helper'

describe Lolcommits::Plugin::Loltext do

  include Lolcommits::TestHelpers::GitRepo
  include Lolcommits::TestHelpers::FakeIO

  def plugin_name
    'loltext'
  end

  it 'should have a name' do
    ::Lolcommits::Plugin::Loltext.name.must_equal plugin_name
  end

  it 'should run on post capturing' do
    ::Lolcommits::Plugin::Loltext.runner_order.must_equal [:postcapture]
  end

  describe 'default font' do
    it 'should have the correct file permissions' do
      font_permissions = File.lstat(Lolcommits::Plugin::Loltext::DEFAULT_FONT_PATH).mode & 0o777
      (font_permissions == 0o644).must_equal(true,
        "expected perms of 644/664 but instead got #{format '%o', font_permissions}")
    end
  end

  describe 'with a runner' do
    def runner
      # a simple lolcommits runner with an empty configuration Hash
      @runner ||= Lolcommits::Runner.new(
        config: OpenStruct.new(read_configuration: {})
      )
    end

    def plugin
      @plugin ||= Lolcommits::Plugin::Loltext.new(runner)
    end

    def valid_enabled_config
      @config ||= OpenStruct.new(
        read_configuration: {
          plugin.class.name => { 'enabled' => true }
        }
      )
    end

    describe 'initalizing' do
      it 'should assign runner and an enabled option' do
        plugin.runner.must_equal runner
        plugin.options.must_equal ['enabled']
      end
    end

    describe '#enabled?' do
      it 'should be true by default' do
        plugin.enabled?.must_equal true
      end

      it 'should true when configured' do
        plugin.runner.config = valid_enabled_config
        plugin.enabled?.must_equal true
      end
    end

    describe 'configuration' do
      it 'should not be configured by default' do
        plugin.configured?.must_equal false
      end

      it 'should allow plugin options to be configured' do
        # enabled
        inputs = ['true']

        # styling message and sha
        inputs += %w(
          red
          myfont.ttf
          SE
          38
          orange
          true
        ) * 2

        # styling overlay
        inputs += %w(true  #2884ae,#7e231f 40)

        # border options
        inputs += %w(#e96d46 true 23)

        configured_plugin_options = {}
        output = fake_io_capture(inputs: inputs) do
          configured_plugin_options = plugin.configure_options!
        end

        configured_plugin_options.must_equal( {
          "enabled" => true,
          message: {
            color: 'red',
            font: 'myfont.ttf',
            position: 'SE',
            size: 38,
            stroke_color: 'orange',
            uppercase: true
          },
          sha: {
            color: 'red',
            font: 'myfont.ttf',
            position: 'SE',
            size: 38,
            stroke_color: 'orange',
            uppercase: true
          },
          overlay: {
            enabled: true,
            overlay_colors: ['#2884ae', '#7e231f'],
            overlay_percent: 40
          },
          border: {
            color: '#e96d46',
            enabled: true,
            size: 23,
          }
        })
      end

      it 'should indicate when configured' do
        plugin.runner.config = valid_enabled_config
        plugin.configured?.must_equal true
      end

      describe '#valid_configuration?' do
        it 'should be trye even if config is not set' do
          plugin.valid_configuration?.must_equal(true)
        end

        it 'should be true for a valid configuration' do
          plugin.runner.config = valid_enabled_config
          plugin.valid_configuration?.must_equal true
        end
      end
    end
  end
end
