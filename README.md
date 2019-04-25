# Lolcommits Loltext

[![Gem](https://img.shields.io/gem/v/lolcommits-loltext.svg?style=flat)](http://rubygems.org/gems/lolcommits-loltext)
[![Travis](https://img.shields.io/travis/com/lolcommits/lolcommits-loltext/master.svg?style=flat)](https://travis-ci.com/lolcommits/lolcommits-loltext)
[![Depfu](https://img.shields.io/depfu/lolcommits/lolcommits-loltext.svg?style=flat)](https://depfu.com/github/lolcommits/lolcommits-loltext)
[![Maintainability](https://api.codeclimate.com/v1/badges/2e0fa03867952572c5db/maintainability)](https://codeclimate.com/github/lolcommits/lolcommits-loltext/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/2e0fa03867952572c5db/test_coverage)](https://codeclimate.com/github/lolcommits/lolcommits-loltext/test_coverage)

[lolcommits](https://lolcommits.github.io/) takes a snapshot with your webcam
every time you git commit code, and archives a lolcat style image with it. Git
blame has never been so much fun!

This plugin annotates each lolcommit with the commit message and sha text. You
can style and position these however you like, or add a transparent overlay
color that covers the entire image.

By default your lolcommit will look something like this (maybe without the
horse):

![horse
commit](https://github.com/lolcommits/lolcommits-loltext/raw/master/assets/images/horse.jpg)

You can easily change the plugin options to achieve something like this:

![hipster
commit](https://github.com/lolcommits/lolcommits-loltext/raw/master/assets/images/hipster.jpg)

See [below](https://github.com/lolcommits/lolcommits-loltext#configuration) for
more information on the options available.

## Requirements

* Ruby >= 2.3
* A webcam
* [ImageMagick](http://www.imagemagick.org)
* [ffmpeg](https://www.ffmpeg.org) (optional) for animated gif capturing

## Installation

By default, this plugin is automatically included with the main lolcommits gem.
If you have uninstalled this gem, install it again with:

    $ gem install lolcommits-loltext

That's it! Every lolcommit will now be stamped with your commit message and sha.
This plugin is enabled by default (if no configuration for it exists). To
disable (so no text or overlay is applied) use:

    $ lolcommits --config -p loltext
    # and set enabled to `false`

### Configuration

Configure this plugin with:

    $ lolcommits --config -p loltext
    # set enabled to `true` (then set your own options or choose the defaults)

The following options are available:

* text color
* text font
* text position
* uppercase text?
* size (point size for the font)
* stroke color (font outline color, or none)
* transparent overlay (cover the image with a random background color)
* transparent overlay % (sets the fill colorize strength)

Please note that:

* The message and sha text can have different text options
* Any blank options will use the default (indicated when prompted for an option)
* Always use the full absolute path to font files
* Valid text positions are NE, NW, SE, SW, S, C (centered)
* Colors can be hex values (#FC0) or strings (white, red etc.)
* You can set one or more `overlay_colors` to pick from, separated with commas

With these options it is possible to create your own unique lolcommit format.
To achieve these '[hipster
styled](https://twitter.com/matthutchin/status/738411190343368704)' 🕶 commits,
try the following:

```
loltext:
  :enabled: true
  :message:
    :color: white
    :font: "/Users/matt/Library/Fonts/Raleway-Light.ttf"
    :position: C
    :size: 30
    :stroke_color: none
    :uppercase: true
  :sha:
    :color: white
    :font: "/Users/matt/Library/Fonts/Raleway-Light.ttf"
    :position: S
    :size: 20
    :stroke_color: none
    :uppercase: false
  :overlay:
    :enabled: true
  :border:
    :enabled: false
```

**NOTE**: you can grab the '_Raleway-Light_' font for free from
[fontsquirrel](https://www.fontsquirrel.com/fonts/Raleway).

## Development

Check out this repo and run `bin/setup`, to install all dependencies and
generate docs. Run `bundle exec rake` to run all tests and generate a coverage
report.

You can also run `bin/console` for an interactive prompt that will allow you to
experiment with the gem code.

## Tests

MiniTest is used for testing. Run the test suite with:

    $ rake test

## Docs

Generate docs for this gem with:

    $ rake rdoc

## Troubles?

If you think something is broken or missing, please raise a new
[issue](https://github.com/lolcommits/lolcommits-loltext/issues). Take
a moment to check it hasn't been raised in the past (and possibly closed).

## Contributing

Bug [reports](https://github.com/lolcommits/lolcommits-loltext/issues) and [pull
requests](https://github.com/lolcommits/lolcommits-loltext/pulls) are welcome on
GitHub.

When submitting pull requests, remember to add tests covering any new behaviour,
and ensure all tests are passing on [Travis
CI](https://travis-ci.com/lolcommits/lolcommits-loltext). Read the
[contributing
guidelines](https://github.com/lolcommits/lolcommits-loltext/blob/master/CONTRIBUTING.md)
for more details.

This project is intended to be a safe, welcoming space for collaboration, and
contributors are expected to adhere to the [Contributor
Covenant](http://contributor-covenant.org) code of conduct. See
[here](https://github.com/lolcommits/lolcommits-loltext/blob/master/CODE_OF_CONDUCT.md)
for more details.

## License

The gem is available as open source under the terms of
[LGPL-3](https://opensource.org/licenses/LGPL-3.0).

## Links

* [Travis CI](https://travis-ci.com/lolcommits/lolcommits-loltext)
* [Test Coverage](https://codeclimate.com/github/lolcommits/lolcommits-loltext/test_coverage)
* [Code Climate](https://codeclimate.com/github/lolcommits/lolcommits-loltext)
* [RDoc](http://rdoc.info/projects/lolcommits/lolcommits-loltext)
* [Issues](http://github.com/lolcommits/lolcommits-loltext/issues)
* [Report a bug](http://github.com/lolcommits/lolcommits-loltext/issues/new)
* [Gem](http://rubygems.org/gems/lolcommits-loltext)
* [GitHub](https://github.com/lolcommits/lolcommits-loltext)
