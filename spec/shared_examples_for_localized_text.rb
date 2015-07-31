RSpec.shared_examples_for 'localized text' do
  describe 'validations' do
    it { expect(subject).to validate_presence_of(:text) }

    it { expect(subject).to validate_presence_of(:language) }
    it { expect(subject).to_not allow_value('ab-XY').for(:language).with_message('is not valid') }
    it { expect(subject).to_not allow_value('xx').for(:language).with_message('is not valid') }
    it { expect(subject).to allow_value('en').for(:language) }
    it { expect(subject).to allow_value('es').for(:language) }
    it { expect(subject).to allow_value('en-US').for(:language) }
  end

  describe 'schema' do
    it { expect(subject).to have_db_column(:language).of_type(:string).with_options(null: true) }
    it { expect(subject).to have_db_column(:text).of_type(:text).with_options(null: true) }

    context 'indexes' do
      it { expect(subject).to have_db_index(:language) }
      it { expect(subject).to have_db_index(:text) }
    end
  end
end
