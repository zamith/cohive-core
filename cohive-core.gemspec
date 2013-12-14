# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cohive/core/version'

Gem::Specification.new do |spec|
  spec.name          = "cohive-core"
  spec.version       = Cohive::Core::VERSION
  spec.authors       = ["Zamith"]
  spec.email         = ["zamith@groupbuddies.com"]
  spec.description   = %q{cohive: the core}
  spec.summary       = %q{The gears behind cohive}
  spec.homepage      = "http://cohive.me"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
