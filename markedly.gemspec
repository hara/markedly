# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'English'
require 'markedly/version'

def windows?
  !!RUBY_PLATFORM.match(/mswin|mingw|cygwin/)
end

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

  spec.add_runtime_dependency 'addressable', '~> 2.3.5'
  spec.add_runtime_dependency 'em-websocket', '~> 0.5.0'
  spec.add_runtime_dependency 'launchy', '~> 2.3.0'
  spec.add_runtime_dependency 'redcarpet', '~> 3.0.0'
  spec.add_runtime_dependency 'pygments.rb', windows? ? '= 0.5.0' : '~> 0.5.4'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 10.1.0'
  spec.add_development_dependency 'rspec', '~> 2.14.1'
  spec.add_development_dependency 'coveralls', '~> 0.7.0'
end
