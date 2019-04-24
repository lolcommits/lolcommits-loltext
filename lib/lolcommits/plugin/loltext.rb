# frozen_string_literal: true

require 'lolcommits/plugin/base'

module Lolcommits
  module Plugin
    class Loltext < Base

      DEFAULT_FONT_PATH = File.join(
        File.dirname(__FILE__), "../../../vendor/fonts/Impact.ttf"
      ).freeze

      # Returns position(s) of when this plugin should run during the capture
      # process. We want to add text to the image after capturing, but before
      # capture is ready for sharing.
      #
      # @return [Array] the position(s) (:post_capture)
      #
      def self.runner_order
        [:post_capture]
      end

      ##
      # Returns true/false indicating if the plugin is enabled or not.
      # Enabled by default (if no configuration exists)
      #
      # @return [Boolean] true/false indicating if plugin is enabled
      #
      def enabled?
        configuration.empty? || super
      end

      ##
      # Returns true/false indicating if the plugin has been correctly
      # configured.
      #
      # Valid by default (if no configuration exists)
      #
      # @return [Boolean] true/false indicating if plugin is correct configured
      #
      def valid_configuration?
        configuration.empty? || super
      end

      ##
      # Prompts the user to configure text options.
      #
      # @return [Hash] a hash of configured plugin options
      #
      def configure_options!
        puts '---------------------------------------------------------------'
        puts '  LolText options '
        puts ''
        puts '  * any blank options will use the (default)'
        puts '  * always use the full absolute path to fonts'
        puts '  * valid text positions are NE, NW, SE, SW, S, C (centered)'
        puts '  * colors can be hex #FC0 value or a string \'white\''
        puts '      - use `none` for no stroke color'
        puts '  * overlay fills your image with a random color'
        puts '      - set one or more overlay_colors with a comma seperator'
        puts '      - overlay_percent (0-100) sets the fill colorize strength'
        puts '---------------------------------------------------------------'

        super
      end

      ##
      #
      # Post-capture hook, runs after lolcommits captures a snapshot.
      #
      # Annotates the image with the git commit message and sha text
      #
      def run_post_capture
        debug 'Annotating image via MiniMagick'
        image = MiniMagick::Image.open(runner.main_image)
        if config_option(:overlay, :enabled)
          image.combine_options do |c|
            c.fill config_option(:overlay, :overlay_colors).split(',').map(&:strip).sample
            c.colorize config_option(:overlay, :overlay_percent)
          end
        end

        if config_option(:border, :enabled)
          image.combine_options do |c|
            c.border "#{config_option(:border, :size)}x#{config_option(:border, :size)}"
            c.bordercolor config_option(:border, :color)
          end
        end

        annotate(image, :message, clean_msg(runner.message))
        annotate(image, :sha, runner.sha)
        debug "Writing changed file to #{runner.main_image}"
        image.write runner.main_image
      end


      private

      def annotate(image, type, string)
        debug("annotating #{type} to image with #{string}")

        transformed_position = position_transform(config_option(type, :position))
        annotate_location = '0'

        padded_annotation = 10
        if config_option(:border, :enabled)
          padded_annotation = padded_annotation + config_option(:border, :size)
        end

        # move all positions off the edge of the image
        case transformed_position
        when "South"
          annotate_location = "+0+#{padded_annotation}"
        when "NorthWest", "SouthWest", "NorthEast", "SouthEast"
          annotate_location = "+#{padded_annotation}+#{padded_annotation}"
        end

        string.upcase! if config_option(type, :uppercase)

        image.combine_options do |c|
          c.strokewidth runner.capture_animated? ? '1' : '2'
          c.interline_spacing(-(config_option(type, :size) / 5))
          c.stroke config_option(type, :stroke_color)
          c.fill config_option(type, :color)
          c.gravity transformed_position
          c.pointsize runner.capture_animated? ? (config_option(type, :size) / 2) : config_option(type, :size)
          c.font config_option(type, :font)
          c.annotate annotate_location, string
        end
      rescue => error
        debug("mogrify annotate returned non-zero status: #{error.message}")
      end

      # default text styling and positions
      def default_options
        {
          message: {
            color: 'white',
            font: DEFAULT_FONT_PATH,
            position: 'SW',
            size: 48,
            stroke_color: 'black',
            uppercase: false
          },
          sha: {
            color: 'white',
            font: DEFAULT_FONT_PATH,
            position: 'NE',
            size: 32,
            stroke_color: 'black',
            uppercase: false
          },
          overlay: {
            enabled: false,
            overlay_colors: [
              '#2e4970', '#674685', '#ca242f', '#1e7882', '#2884ae', '#4ba000',
              '#187296', '#7e231f', '#017d9f', '#e52d7b', '#0f5eaa', '#e40087',
              '#5566ac', '#ed8833', '#f8991c', '#408c93', '#ba9109'
            ].join(','),
            overlay_percent: 50
          },
          border: {
            enabled: false,
            color: 'white',
            size: 10,
          }
        }
      end

      # explode psuedo-names for text positioning
      def position_transform(position)
        case position
        when 'NE'
          'NorthEast'
        when 'NW'
          'NorthWest'
        when 'SE'
          'SouthEast'
        when 'SW'
          'SouthWest'
        when 'C'
          'Center'
        when 'S'
          'South'
        end
      end

      # do whatever is required to commit message to get it clean and ready for
      # imagemagick
      def clean_msg(text)
        wrapped_text = word_wrap text
        escape_quotes wrapped_text
        escape_ats wrapped_text
      end

      # conversion for quotation marks to avoid shell interpretation
      def escape_quotes(text)
        text.gsub(/"/, "''")
      end

      def escape_ats(text)
        text.gsub(/@/, '\@')
      end

      # convenience method for word wrapping
      # based on https://github.com/cmdrkeene/memegen/blob/master/lib/meme_generator.rb
      def word_wrap(text, col = 27)
        wrapped = text.gsub(/(.{1,#{col + 4}})(\s+|\Z)/, "\\1\n")
        wrapped.chomp!
      end
    end
  end
end
