# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lolcommits/loltext/version'

Gem::Specification.new do |spec|
  spec.name          = "lolcommits-loltext"
  spec.version       = Lolcommits::Loltext::VERSION
  spec.authors       = ["Matthew Hutchinson"]
  spec.email         = ["matt@hiddenloop.com"]
  spec.summary       = %q{lolcommits commit message annotation plugin}

  spec.description = <<-EOF
  Overlay the commit message and sha on your lolcommit. Configure text style,
  positioning and an optional transparent overlay.
  EOF

  spec.homepage      = "https://github.com/lolcommits/lolcommits-loltext"
  spec.license       = "LGPL-3"

  spec.metadata = {
    "homepage_uri"    => "https://github.com/lolcommits/lolcommits-loltext",
    "changelog_uri"   => "https://github.com/lolcommits/lolcommits-loltext/blob/master/CHANGELOG.md",
    "source_code_uri" => "https://github.com/lolcommits/lolcommits-loltext",
    "bug_tracker_uri" => "https://github.com/lolcommits/lolcommits-loltext/issues",
  }

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(assets|test|features)/}) }
  spec.test_files    = `git ls-files -- {test,features}/*`.split("\n")
  spec.bindir        = "bin"
  spec.executables   = []
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.3"

  spec.add_development_dependency "lolcommits", ">= 0.11.0"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "simplecov"
end
