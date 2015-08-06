require 'rails_helper'
require 'active_support/json'

describe TranslationCache do
  def lookup(text, lang)
    # The cache supports gettext style translations, hence the separator
    I18n.t text, locale: lang, separator: '|'
  end

  let(:source) { Fabricate(:source, translations: [translation]) }
  let(:translation) { Fabricate.build(:translation, language: 'es') }

  before :all do
    @old_handler = I18n.exception_handler
    # On missing translation return nil
    I18n.exception_handler = ->(*_) {}
  end

  after(:all) { I18n.exception_handler = @old_handler }

  describe '#delete' do
    context 'given an existing Source' do
      describe "when it's deleted" do
        let(:other_source) { Fabricate.build(:source, text: '___FooBooHoo___') }

        before do
          other_source.save!
          source.destroy
        end

        it 'removes its translations from the cache' do
          source.translations.each do |translation|
            val = lookup(source.text, translation.language)
            expect(val).to be nil
          end
        end

        it "does not remove other sources' translations from the cache" do
          other_source.translations.each do |translation|
            val = lookup(other_source.text, translation.language)
            expect(val).to eq translation.text
          end
        end
      end

      describe 'when only one of its translations is deleted' do
        before do
          %w(fr pt).each { |lang| source.translations << Fabricate.build(:translation, language: lang) }
          source.translations.last.destroy
        end

        it 'removes the deleted translation from the cache' do
          translation = source.translations.last
          val = lookup(source.text, translation.language)
          expect(val).to be nil
        end

        it 'does not remove the remaining translations from the cache' do
          source.translations[0..-2].each do |translation|
            val = lookup(source.text, translation.language)
            expect(val).to eq translation.text
          end
        end
      end

      describe 'when a Source is deleted' do
        it 'removes its translations from the cache' do
          source.destroy
          source.translations.each do |translation|
            val = lookup(source.text, translation.language)
            expect(val).to be nil
          end
        end
      end
    end
  end

  describe '#update' do
    context 'given a new Source' do
      context 'with one translation' do
        it 'adds the translation to the cache' do
          val = lookup(source.text, translation.language)
          expect(val).to eq translation.text
        end
      end

      context 'with multiple translations' do
        it 'adds all the translations to the cache' do
          source.translations << Fabricate.build(:translation)
          source.translations.each do |translation|
            val = lookup(source.text, translation.language)
            expect(val).to eq translation.text
          end
        end
      end
    end

    context 'given an existing Source with updated text' do
      ### Little fragile here...
      let!(:old_text) { source.text }
      before { source.update!(text: 'Foooh!') }
      ###

      it 'updates the cache with the new text' do
        val = lookup(source.text, translation.language)
        expect(val).to eq translation.text
      end

      it 'removes the old text from the cache' do
        val = lookup(old_text, translation.language)
        expect(val).to be nil
      end
    end
  end
end
