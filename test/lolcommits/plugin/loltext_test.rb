# frozen_string_literal: true

require 'test_helper'

describe Lolcommits::Plugin::Loltext do

  include Lolcommits::TestHelpers::FakeIO

  it 'should run on post capturing' do
    _(::Lolcommits::Plugin::Loltext.runner_order).must_equal [:post_capture]
  end

  describe 'with a runner' do
    def runner
      # a simple lolcommits runner with an empty configuration Hash
      @runner ||= Lolcommits::Runner.new
    end

    def plugin
      @plugin ||= Lolcommits::Plugin::Loltext.new(runner: runner)
    end

    def valid_enabled_config
      { enabled: true }
    end

    describe 'initalizing' do
      it 'should assign runner and an enabled option' do
        _(plugin.runner).must_equal runner
        _(plugin.options).must_equal [:enabled]
      end
    end

    describe '#enabled?' do
      it 'should be true by default' do
        _(plugin.enabled?).must_equal true
      end

      it 'should true when configured' do
        plugin.configuration = valid_enabled_config
        _(plugin.enabled?).must_equal true
      end
    end

    describe 'configuration' do
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
        inputs += %w(true #2884ae,#7e231f 40)

        # border options
        inputs += %w(true #e96d46 23)

        configured_plugin_options = {}
        fake_io_capture(inputs: inputs) do
          configured_plugin_options = plugin.configure_options!
        end

        _(configured_plugin_options).must_equal( {
          enabled: true,
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
            overlay_colors: "#2884ae,#7e231f",
            overlay_percent: 40
          },
          border: {
            enabled: true,
            color: '#e96d46',
            size: 23,
          }
        })
      end

      describe '#valid_configuration?' do
        it 'should be trye even if config is not set' do
          _(plugin.valid_configuration?).must_equal(true)
        end

        it 'should be true for a valid configuration' do
          plugin.configuration = valid_enabled_config
          _(plugin.valid_configuration?).must_equal true
        end
      end
    end
  end
end
