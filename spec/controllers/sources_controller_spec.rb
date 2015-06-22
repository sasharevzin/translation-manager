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

  describe 'POST #create' do
    describe 'with valid params' do
      it 'returns 302 response for successful creation' do
        post :create, source: valid_attributes
        expect(response.status).to eq(302)
      end

      it 'changes the count of Source translations by one on successful creation' do
        expect{
            post :create, source: valid_attributes
          }.to change{ Source.count}.by(1)
      end

      it 'redirects to source translation page upon successful creation of source' do
        post :create, source: valid_attributes
        expect(response).to redirect_to(Source.last)
      end
    end

    describe 'with invalid params' do
      describe 'source attributes' do
        it 'should raise exception if required params are not passed' do
          expect{
            post :create
          }.to raise_error(ActionController::ParameterMissing)
        end

        it 'assigns a newly created but unsaved source translation as @source' do
          post :create, source: { language: 'zy', text: Faker::Lorem.paragraph}
          expect(assigns(:source)).to be_a_new(Source)
        end

        it 're-renders new template' do
          post :create, source: { language: 'zy', text: Faker::Lorem.paragraph}
          expect(response).to render_template(:new)
        end
      end

      describe 'translations attributes' do
        let(:source_params) do
          {  language:'en-US',
               text: Faker::Lorem.paragraph,
               translations_attributes:
               {
                '0' => {
                    text: Faker::Lorem.paragraph
                  }
              }
            }
        end

        it 'assigns a newly created but unsaved source translation as @source' do
          post :create, source: source_params
          expect(assigns(:source)).to be_a_new(Source)
        end

        it 're-renders new template' do
          post :create, source: source_params
          expect(response).to render_template(:new)
        end
      end

    end
  end

end
