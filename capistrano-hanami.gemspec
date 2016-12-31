# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/hanami/version'

Gem::Specification.new do |spec|
  spec.name          = 'capistrano-hanami'
  spec.version       = Capistrano::Hanami::VERSION
  spec.authors       = ['Mikhail Grachev']
  spec.email         = ['work@mgrachev.com']

  spec.summary       = %q{Hanami tasks for Capistrano}
  spec.description   = %q{Hanami tasks for Capistrano}
  spec.homepage      = 'https://github.com/mgrachev/capistrano-hanami'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'capistrano', '~> 3.7'
  spec.add_dependency 'capistrano-bundler', '~> 1.2'

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
