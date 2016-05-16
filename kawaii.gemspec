# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kawaii/version'

Gem::Specification.new do |spec|
  spec.name          = 'kawaii-api'
  spec.version       = Kawaii::VERSION
  spec.authors       = ['rybex']
  spec.email         = ['tomek.rybka@gmail.com']
  spec.summary       = 'Micro API framework'
  spec.description   = 'Micro API framework to develop web applications in ruby'
  spec.homepage      = 'https://github.com/rybex/kawaii'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z -- lib/* bin/* LICENSE.txt README.md kawaii.gemspec`.split("\x0")
  spec.executables   = ['kawaii-api']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake',    '~> 10.0'
  spec.add_development_dependency 'rspec',   '~> 3.4.0'
  spec.add_development_dependency 'pry',     '~> 0.10.3'
  spec.add_development_dependency 'rubocop', '~> 0.40'

  spec.add_runtime_dependency 'rack',        '~> 1.6.4'
  spec.add_runtime_dependency 'thor',        '~> 0.19.1'
end
