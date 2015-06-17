# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'interaction/version'

Gem::Specification.new do |spec|
  spec.name          = "simple interaction"
  spec.version       = Interaction::VERSION
  spec.authors       = ["Jose Boza"]
  spec.email         = ["jaboza@gmail.com"]
  spec.summary       = %q{Keep your code clean with simple interactions}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
