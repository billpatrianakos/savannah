# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'savannah/version'

Gem::Specification.new do |spec|
  spec.name          = "savannah"
  spec.version       = Savannah::VERSION
  spec.authors       = ["Bill Patrianakos"]
  spec.email         = ["bill@cleverwebdesign.net"]
  spec.description   = %q{Another simple Ruby web framework}
  spec.summary       = %q{Savannah}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'rack'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
