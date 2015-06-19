require 'rails_helper'

RSpec.describe Translation, type: :model do
  let(:source) { FactoryGirl.create(:source) }
  let(:translation) do
    t = FactoryGirl.create(:translation)
    source.translations << t
    t
  end

  context 'relationships' do
    it { expect(translation).to belong_to(:source) }
  end
end
