require 'rails_helper'

RSpec.describe SourcesController, type: :controller do
  let(:valid_attributes) do
    {  language:'en-US',
               text: Faker::Lorem.paragraph,
               translations_attributes:
               {
                '0' => {
                    language: 'en-US',
                    text: Faker::Lorem.paragraph
                    },
                '1' => {
                  language: 'en-US',
                  text: Faker::Lorem.paragraph
                  }
              }
            }
  end

  describe '#create' do
    it 'returns 200 response for successful creation' do
      post :create, source: valid_attributes
      expect(response.status).to eq(201)
    end
  end
end
