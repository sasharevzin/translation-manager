require 'rails_helper'

RSpec.describe Source, type: :model do
  context 'schema' do
    context 'required database columns' do
      it { expect(subject).to have_db_column(:context).of_type(:string).with_options(null: true) }
      it { expect(subject).to have_db_column(:language).of_type(:string).with_options(null: true) }
      it { expect(subject).to have_db_column(:text).of_type(:text).with_options(null: true) }
    end

    context 'required indexes on columns' do
      it { expect(subject).to have_db_index(:context) }
      it { expect(subject).to have_db_index(:language) }
      it { expect(subject).to have_db_index(:text) }
    end
  end

  context 'relationships' do
    it { expect(subject).to have_many(:translations) }
  end

  context 'validations' do
    it { expect(subject).to validate_presence_of(:text) }
    it { expect(subject).to validate_presence_of(:language) }
    it { expect(subject).to_not allow_value("ab-XY").for(:language) }
    it { expect(subject).to allow_value("en-US").for(:language) }
  end

  context 'locale validator' do
    it 'returns error for abc as locale' do
      source = Source.new(language: 'abc123')
      source.save
      expect(source.errors.full_messages).to include("Language is not valid ")
    end
  end

end
