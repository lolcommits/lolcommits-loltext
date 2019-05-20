lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lolcommits/loltext/version'

Gem::Specification.new do |spec|
  spec.name     = "lolcommits-loltext"
  spec.version  = Lolcommits::Loltext::VERSION
  spec.authors  = ["Matthew Hutchinson"]
  spec.email    = ["matt@hiddenloop.com"]
  spec.summary  = %q{lolcommits commit message annotation plugin}
  spec.homepage = "https://github.com/lolcommits/lolcommits-loltext"
  spec.license  = "LGPL-3.0"

  spec.description = <<-DESC
  Overlay the commit message and sha on your lolcommit. Configure text
  style, positioning, border and coloured overlay.
  DESC

  spec.metadata = {
    "homepage_uri"      => "https://github.com/lolcommits/lolcommits-loltext",
    "changelog_uri"     => "https://github.com/lolcommits/lolcommits-loltext/blob/master/CHANGELOG.md",
    "source_code_uri"   => "https://github.com/lolcommits/lolcommits-loltext",
    "bug_tracker_uri"   => "https://github.com/lolcommits/lolcommits-loltext/issues",
    "allowed_push_host" => "https://rubygems.org"
  }

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(assets|test|features)/}) }
  spec.test_files    = `git ls-files -- {test,features}/*`.split("\n")
  spec.bindir        = "bin"
  spec.executables   = []
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.3"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "simplecov"
end
