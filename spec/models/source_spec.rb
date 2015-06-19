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
end
