require 'rails_helper'

RSpec.describe SourcesController, type: :controller do
  let(:valid_attributes) {Fabricate.attributes_for(:source)}

  describe 'GET #index' do
    it 'assigns sources as @sources' do
      get :index
      expect(assigns(:sources)).to be_kind_of(ActiveRecord::Relation)
    end

    it 'returns first source from @sources' do
      2.times { Fabricate(:source) }
      get :index
      expect(assigns(:sources).first).to be_kind_of(Source)
    end

    it 'returns translations from first source from @sources' do
      2.times { Fabricate(:source) }
      get :index
      expect(assigns(:sources).first.translations.first).to be_kind_of(Translation)
    end

  end

  describe 'GET #new' do
    it 'assigns a new source as @source' do
      get :new, {}
      expect(assigns(:source)).to be_a_new(Source)
    end

    it 'assigns translations as @translations' do
      get :new, {}
      expect(assigns(:translations)).to be_a_new(Translation)
    end
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

        it 'assigns a newly created but unsaved source translation as @source' do
          source_params[:translations_attributes]['0'][:language] = 'abc'
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
