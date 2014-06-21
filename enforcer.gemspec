# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'enforcer/version'

Gem::Specification.new do |spec|
  spec.name          = "enforcer"
  spec.version       = Enforcer::VERSION
  spec.authors       = ["foostan"]
  spec.email         = ["ks@fstn.jp"]
  spec.summary       = %q{Enforce tasks to consul cluster by attender notification.}
  spec.description   = %q{Enforce tasks to consul cluster by attender notification.}
  spec.homepage      = "https://github.com/foostan/enforcer"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_dependency "attender"
  spec.add_dependency "capistrano"
end
