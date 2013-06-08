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

    def initialize(extensions = {}, renderer_options = {})
      extensions ||= DEFAULT_EXTENSIONS
      renderer_options ||= DEFAULT_RENDERER_OPTIONS
      renderer = Redcarpet::Render::HTML.new(renderer_options)
      @markdown = Redcarpet::Markdown.new(renderer, extensions)
    end

    def render(text)
      @markdown.render(text)
    end

  end

end
