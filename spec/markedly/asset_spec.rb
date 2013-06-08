# coding: utf-8
require_relative '../spec_helper'

module Markedly
  describe Asset do
  end

  describe CssAsset do
    shared_context 'remote' do
      let(:url) { 'http://example.com/css/main.css' }
      let(:css) { CssAsset.new(url) }
    end

    shared_context 'predefined' do
      let(:name) { 'github' }
      let(:css) { CssAsset.asset(name) }
    end

    shared_context 'custom' do
      let(:path) { docs('custom.css') }
      let(:css) { CssAsset.new(path) }
    end

    describe '#name' do
      context 'when remote css' do
        include_context 'remote'
        it { expect(css.name).to eq('main') }
      end

      context 'when predefined css' do
        include_context 'predefined'
        it { expect(css.name).to eq('github') }
      end

      context 'when custom css' do
        include_context 'custom'
        it { expect(css.name).to eq('custom') }
      end
    end

    describe '#path' do
      context 'when remote css' do
        include_context 'remote'
        it { expect(css.path).to eq(url) }
      end

      context 'when predefined css' do
        include_context 'predefined'
        it { expect(css.path).to eq(assets('github.css')) }
      end

      context 'when custom css' do
        include_context 'custom'
        it { expect(css.path).to eq(docs('custom.css')) }
      end
    end

    describe '#href' do

      context 'when remote css' do
        include_context 'remote'
        it 'returns http/https scheme url' do
          expect(css.href).to eq(url)
        end
      end

      context 'when predefined css' do
        include_context 'predefined'
        it 'returns file scheme url' do
          expected = Addressable::URI.convert_path(assets('github.css')).to_s
          expect(css.href).to eq(expected)
        end
      end

      context 'when custom css' do
        include_context 'custom'
        it 'returns file scheme url' do
          expected = Addressable::URI.convert_path(docs('custom.css')).to_s
          expect(css.href).to eq(expected)
        end
      end
    end

    describe '#remote' do

      context 'when remote css' do
        include_context 'remote'
        it { expect(css.remote?).to be_true }
      end

      context 'when predefined css' do
        include_context 'predefined'
        it { expect(css.remote?).to be_false }
      end

      context 'when custom css' do
        include_context 'custom'
        it { expect(css.remote?).to be_false }
      end

    end

  end

end

