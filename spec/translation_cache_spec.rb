require 'rails_helper'

describe TranslationCache do
  before(:all) { @redis = Redis.new }

  after do
    @redis.keys.each { |k| @redis.del(k) }
  end

  describe '#update' do
    context 'given a new Source' do
      context 'without translations' do
        it 'does not update the cache' do 
          Fabricate(:source, translations: [])
          expect(@redis.keys.size).to eq 0
        end
      end

      context 'with one translation' do
        it 'adds the translation to the cache' do 
          translation = Fabricate.build(:translation)
          source = Fabricate(:source, :text => 'foo', translations: [translation])

          key = sprintf "%s.%s", translation.language, source.text
          expect(@redis.get(key)).to eq translation.text
        end
      end
    end

    context 'given an updated Source' do
      it 'does not update the cache' do 
        Fabricate(:source)
        expect(@redis.keys.size).to eq 0
      end


      context 'given an updated Source without any translations' do
        it 'does not update the cache' do 
          Fabricate(:source)
          expect(@redis.keys.size).to eq 0
        end
      end
    end
  end
end
