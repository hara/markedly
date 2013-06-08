# coding: utf-8
require_relative '../spec_helper'

module Markedly
  describe Document  do

    describe '#initialize' do
      let(:document) { Document.new(docs('markdown.md')) }

      it 'creates destination file' do
        expect(File.exist?(document.destination)).to be_true
      end

    end

    describe '#path' do
      let(:document) { Document.new(docs('markdown.md')) }

      it 'returns the URL path' do
        expect(document.path).to eq('markdown.md')
      end
    end

    describe '#convert' do
      let(:source) { docs('markdown.md') }

      context 'when does not have css' do
        let(:destination) { docs('markdown.html') }
        let(:document) { Document.new(source) }

        it 'outputs HTML' do
          document.convert
          expected = File.read(destination)
          expect(File.read(document.destination)).to eq(expected)
        end
      end

      context 'when has css' do
        let(:destination) { docs('markdown.github.html.erb') }
        let(:document) { Document.new(source, css: 'github') }

        it 'outputs HTML' do
          document.convert
          css = CssAsset.asset('github').href
          expected = ERB.new(File.read(destination)).result(binding)
          expect(File.read(document.destination)).to eq(expected)
        end
      end

    end

  end

end

