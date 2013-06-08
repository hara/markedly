# coding: utf-8
require 'addressable/uri'

module Markedly

  class Asset
    ASSETS_DIR = File.expand_path('../../../assets', __FILE__)

    attr_reader :name
    attr_reader :path
    attr_reader :href

    def initialize(path)
      @path = path
      ext = File.extname(@path)
      @name = File.basename(path, ext)
      prepare_href
    end

    def remote?
      @remote
    end

    private

    def prepare_href
      if @path =~ /^https?:\/\//
        @href = @path
        @remote = true
      else
        @href = Addressable::URI.convert_path(@path).to_s
        @remote = false
      end
    end

  end

  class CssAsset < Asset

    def self.assets
      Dir["#{Asset::ASSETS_DIR}/*.css"].map {|path| CssAsset.new(path) }
    end

    def self.asset(name)
      assets.find { |asset| asset.name == name }
    end

    def initialize(path)
      super
    end

  end

end
