# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kawaii/version'

Gem::Specification.new do |spec|
  spec.name          = "kawaii-api"
  spec.version       = Kawaii::VERSION
  spec.authors       = ["rybex"]
  spec.email         = ["tomek.rybka@gmail.com"]
  spec.summary       = %q{Micro API framework}
  spec.description   = %q{Micro API framework to develop web applications in ruby}
  spec.homepage      = "https://github.com/rybex/kawaii"
  spec.license       = "MIT"

  spec.files         = Dir['lib/**/*.rb']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake",    "~> 10.0"
  spec.add_development_dependency "rspec",   "~> 3.4.0"
  spec.add_development_dependency "pry",     "~> 0.10.3"

  spec.add_runtime_dependency "rack",        "~> 1.6.4"
end
