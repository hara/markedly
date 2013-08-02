require 'coveralls'
Coveralls.wear!

require 'simplecov'
SimpleCov.start do
  add_filter "/assets/"
  add_filter "/spec/doc/"
  add_filter "/vendor/"
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'markedly'

def docs(name)
  File.expand_path(name, File.join(File.dirname(__FILE__), 'docs'))
end

def assets(name)
  File.expand_path(name, File.join(File.dirname(__FILE__), '../assets'))
end

