# coding: utf-8
require 'erb'
require 'tempfile'
require 'uri'
require 'addressable/uri'

module Markedly
  # Represents a markdown document.
  class Document
    DEFAULT_PORT = 8080

    attr_reader :source
    attr_reader :destination
    attr_reader :path
    attr_reader :uri
    attr_reader :css
    attr_reader :port

    # Initializes with source file.
    #
    # source - The String filename of the markdown document.
    def initialize(source, options = {})
      @source = File.expand_path(source)
      @path = File.basename(source)
      @port = options[:port] || DEFAULT_PORT
      @markdown = Markdown.new(options[:parse], options[:render])
      initialize_template
      initialize_assets(options)
      initialize_destination
    end

    # Converts the markdown for preview.
    #
    # Returns nothing.
    def convert
      @dest_file.rewind
      @dest_file.write render(body_html, @css, @port)
      @dest_file.truncate(@dest_file.pos)
      @dest_file.flush
    end

    private

    def initialize_assets(options = {})
      css = options[:css]
      if css.nil?
        @css = nil
      elsif File.file?(css)
        @css = CssAsset.new(File.expand_path(css))
      elsif css =~ URI.regexp(%w(http https))
        @css = CssAsset.new(css)
      else
        @css = CssAsset.asset(css)
      end
    end

    def initialize_template(options = {})
      asset_dir = File.expand_path('../../../assets', __FILE__)
      @template = File.join(asset_dir, 'document.html.erb')
    end

    def initialize_destination
      basename = [File.basename(source), '.html']
      @dest_file = Tempfile.open(basename)
      @destination = @dest_file.path
      @uri = Addressable::URI.convert_path(@destination).to_s
    end

    def body_html
      content = File.read(@source)
      @markdown.render(content)
    end

    def render(body, css, port)
      erb = ERB.new(File.read(@template), nil, '-')
      erb.result(binding)
    end
  end
end
