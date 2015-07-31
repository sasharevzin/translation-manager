require 'rails_helper'
require 'shared_examples_for_localized_text'

RSpec.describe Translation, type: :model do
  it_behaves_like 'localized text'

  describe 'schema' do
    it { expect(subject).to have_db_column(:source_id).of_type(:integer).with_options(null: true) }

    context 'indexes' do
      it { expect(subject).to have_db_index(:source_id) }
    end
  end

  describe 'relationships' do
    it { expect(subject).to belong_to(:source) }
  end

  describe 'validations' do
    it { expect(subject).to validate_uniqueness_of(:language).scoped_to(:source_id) }
  end
end
