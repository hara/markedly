# coding: utf-8
require 'redcarpet'

module Markedly

  class Markdown

    AVAILABLE_EXTENSIONS = [
      :no_intra_emphasis,
      :tables,
      :fenced_code_blocks,
      :autolink,
      :disable_indented_code_blocks,
      :strikethrough,
      :lax_spacing,
      :space_after_headers,
      :superscript,
      :underline,
      :highlight,
    ]

    DEFAULT_EXTENSIONS = {
      tables: true,
      fenced_code_blocks: true,
      autolink: true,
    }

    RENDERER_OPTIONS = [
      :filter_html,
      :no_images,
      :no_links,
      :no_styles,
      :safe_links_only,
      :with_toc_data,
      :hard_wrap,
      :xhtml,
      :prettify,
      :link_attributes
    ]

    DEFAULT_RENDERER_OPTIONS = {}

    module WithPygments
      require 'pygments'

      def block_code(code, language)
        Pygments.highlight(code, lexer: language || 'text')
      end
    end

    def initialize(extensions = {}, renderer_options = {})
      extensions ||= DEFAULT_EXTENSIONS
      renderer_options ||= DEFAULT_RENDERER_OPTIONS
      renderer_class = Class.new(Redcarpet::Render::HTML) do
        include WithPygments if Markdown.python_available?
      end
      renderer = renderer_class.new(renderer_options)
      @markdown = Redcarpet::Markdown.new(renderer, extensions)
    end

    def render(text)
      @markdown.render(text)
    end

    private

    def self.python_available?
      executable?('python2') || executable?('python')
    end

    def self.executable?(command)
      if RUBY_PLATFORM =~ /mswin|mingw/
        exts = ENV['PATHEXT'].split(';')
        exts.map {|ext| command + ext }.each do |exe|
          ENV['PATH'].gsub('\\', '/').split(';').map {|dir| File.join(dir, exe) }.each do |path|
            return true if File.executable?(path)
          end
        end
        return false
      end

      system("which #{command} > /dev/null 2>&1")
    end

  end

end
