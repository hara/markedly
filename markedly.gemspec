# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'English'
require 'markedly/version'

Gem::Specification.new do |spec|
  spec.name          = 'markedly'
  spec.version       = Markedly::VERSION
  spec.authors       = ['Yoshihiro Hara']
  spec.description   = %q{Markedly offers live preview feature to your favorite browser.}
  spec.summary       = %q{A live-reloadable markdown previewer}
  spec.homepage      = 'https://github.com/hara/markedly'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($RS)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'addressable'
  spec.add_dependency 'em-websocket'
  spec.add_dependency 'launchy'
  spec.add_dependency 'redcarpet'
  spec.add_dependency 'pygments.rb'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'coveralls'
end
