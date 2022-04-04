require 'rails_helper'

RSpec.describe TemplatesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:office) { create(:office, created_by: user) }
  let(:data_model) { create(:data_model, office: office) }
  let(:template) { create(:template, data_model: data_model) }

  before do
    sign_in user
    allow(controller).to receive(:authorize_admin!).and_return(true)
    allow(controller).to receive(:current_office).and_return(office)
  end

  describe '#create' do
    context 'with valid params' do
      let(:valid_params) do
        {
          data_model_id: data_model.id,
          template: {
            name: 'Project'
          }
        }
      end

      it 'redirects to data_model path' do
        post :create, params: slug(valid_params)

        expect(response).to redirect_to([office, data_model])
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        {
          data_model_id: data_model.id,
          template: {
            name: ''
          }
        }
      end

      it 'redirects to data_model path' do
        post :create, params: slug(invalid_params)

        expect(response).to render_template(:new)
      end
    end
  end

  describe '#update' do
    context 'with valid params' do
      let(:valid_params) do
        {
          id: template.id,
          template: {
            name: 'Project'
          }
        }
      end

      it 'redirects to data_model path' do
        patch :update, params: slug(valid_params)

        expect(response).to redirect_to([office, data_model])
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        {
          id: template.id,
          template: {
            name: ''
          }
        }
      end

      it 'redirects to data_model path' do
        patch :update, params: slug(invalid_params)

        expect(response).to render_template(:edit)
      end
    end
  end

  describe '#destroy_modal' do
    it 'renders destroy modal' do
      get :destroy_modal, params: slug(id: template.id), xhr: true, format: :js

      expect(response).to render_template(:destroy_modal)
    end
  end

  describe '#destroy' do
    it 'deletes document' do
      delete :destroy, params: slug(id: template.id)

      expect(response).to redirect_to([office, data_model])
      expect(data_model.templates.count).to eq(0)
    end
  end
end
