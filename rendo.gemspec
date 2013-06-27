# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rendo/version'

Gem::Specification.new do |spec|
  spec.name          = "rendo"
  spec.version       = Rendo::VERSION
  spec.authors       = ["Jon Willesen"]
  spec.email         = ["git@wizardwell.net"]
  spec.summary       = %q{Learn regexes by playing Regex Zendo.}
  spec.homepage      = "https://github.com/jwillesen/rendo"
  spec.license       = "MIT"
  spec.description   = <<-DESC
A gem to play a game of regex zendo. Supply the regexes and test strings against
them to see how the strings match. Mostly intendend for presentations or
interactive learning sessions.
DESC

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-minitest"
  spec.add_development_dependency "terminal-notifier-guard"
end
