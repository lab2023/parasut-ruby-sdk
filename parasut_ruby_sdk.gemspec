# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'parasut_ruby_sdk/version'

Gem::Specification.new do |spec|
  spec.name          = 'parasut_ruby_sdk'
  spec.version       = ParasutRubySdk::VERSION
  spec.authors       = ['Lab2023']
  spec.email         = ['info@lab2023.com']

  spec.summary       = %q{Paraşüt SDK}
  spec.description   = %q{Paraşüt SDK}
  spec.homepage      = 'https://github.com/lab2023/parasut-ruby-sdk'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
end
