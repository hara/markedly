$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'markedly'

def docs(name)
  File.expand_path(name, File.join(File.dirname(__FILE__), 'docs'))
end

def assets(name)
  File.expand_path(name, File.join(File.dirname(__FILE__), '../assets'))
end

