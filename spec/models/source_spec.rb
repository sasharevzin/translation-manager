require 'rails_helper'
require 'shared_examples_for_localized_text'

RSpec.describe Source, type: :model do
  it_behaves_like 'localized text'

  describe 'schema' do
    it { expect(subject).to have_db_column(:context).of_type(:string).with_options(null: true) }

    context 'indexes' do
      it { expect(subject).to have_db_index(:context) }
    end
  end

  describe 'relationships' do
    it { expect(subject).to have_many(:translations) }
  end

  describe 'validations' do
    it { expect(subject).to validate_uniqueness_of(:text).scoped_to(:language) }
  end
end
