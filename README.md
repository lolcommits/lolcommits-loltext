# Lolcommits Loltext

[![Gem Version](https://img.shields.io/gem/v/lolcommits-loltext.svg?style=flat)](http://rubygems.org/gems/lolcommits-loltext)
[![Travis Build Status](https://travis-ci.org/lolcommits/lolcommits-loltext.svg?branch=master)](https://travis-ci.org/lolcommits/lolcommits-loltext)
[![Coverage Status](https://coveralls.io/repos/github/lolcommits/lolcommits-loltext/badge.svg?branch=master)](https://coveralls.io/github/lolcommits/lolcommits-loltext)
[![Code Climate](https://codeclimate.com/github/lolcommits/lolcommits-loltext/badges/gpa.svg)](https://codeclimate.com/github/lolcommits/lolcommits-loltext)
[![Gem Dependency Status](https://gemnasium.com/badges/github.com/lolcommits/lolcommits-loltext.svg)](https://gemnasium.com/github.com/lolcommits/lolcommits-loltext)

[lolcommits](https://lolcommits.github.io/) takes a snapshot with your webcam
every time you git commit code, and archives a lolcat style image with it. Git
blame has never been so much fun!

This plugin annotates your lolcommit with the commit message and sha text. You
can style and position these anyway you like, or add a transparent overlay color
that covers the entire image.

By default your lolcommit will look something like this:

<img width='320' height='240'
src='http://farm8.staticflickr.com/7378/10213630734_17d59a3482.jpg' title='horse
commit' />

You can easily apply fonts and coloring to achieve something like this:

<img width='320' height='240'
src='https://pbs.twimg.com/media/Cj9dD_jWsAAVj3G.jpg' title='hipster commit' />

See [below]() for more information on the options available.

## Requirements

* Ruby >= 2.0.0
* A webcam
* [ImageMagick](http://www.imagemagick.org)
* [ffmpeg](https://www.ffmpeg.org) (optional) for animated gif capturing

## Installation

By default, this plugin is automatically included with the main lolcommits gem.
If you happen to uninstall this plugin gem, install it back with:

    $ gem install lolcommits-loltext

Then configure and enable this plugin with:

    $ lolcommits --config -p loltext
    # set enabled to `true` (and set other options or choose the defauts)

That's it! Every lolcommit will now be stamped with your commit message and sha.
Setting enabled to `false` will disable this plugin, an no text or color
overlays will be applied.

### Configuration

Configure this plugin with:

    lolcommits --config -p loltext

The following options are available:

* text color
* text font
* text position
* uppercase text?
* size (point size for the font)
* stroke color (font outline color)
* transparent overlay (fills your image with a random background color)
* transparent overlay % (sets the fill colorise strength)

Please note that:

* The message and sha text can have different text options
* Always use the full absolute path to fonts
* Any blank options will use the default (indicated when prompted for an option)
* Valid text positions are NE, NW, SE, SW, S, C (centered)
* Colors can be hex #FC0 values or strings 'white'
* You can set one or more `overlay_colors` to pick from, separated with commas

With these options it's possible to create your own unique lolcommit format.
For example, to achieve these
[hipster-styled](https://twitter.com/matthutchin/status/738411190343368704)
commits, try the following:

```
loltext:
  enabled: true
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
CI](https://travis-ci.org/lolcommits/lolcommits-loltext). Read the
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

* [Travis CI](https://travis-ci.org/lolcommits/lolcommits-loltext)
* [Test Coverage](https://coveralls.io/github/lolcommits/lolcommits-loltext)
* [Code Climate](https://codeclimate.com/github/lolcommits/lolcommits-loltext)
* [RDoc](http://rdoc.info/projects/lolcommits/lolcommits-loltext)
* [Issues](http://github.com/lolcommits/lolcommits-loltext/issues)
* [Report a bug](http://github.com/lolcommits/lolcommits-loltext/issues/new)
* [Gem](http://rubygems.org/gems/lolcommits-loltext)
* [GitHub](https://github.com/lolcommits/lolcommits-loltext)
