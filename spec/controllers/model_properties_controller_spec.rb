require 'rails_helper'

RSpec.describe ModelPropertiesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:office) { create(:office, created_by: user) }
  let(:data_model) { create(:data_model, office: office) }
  let(:model_property) { create(:model_property, data_model: data_model) }

  before do
    sign_in user
    allow(controller).to receive(:authorize_admin!).and_return(true)
    allow(controller).to receive(:current_office).and_return(office)
  end

  describe '#new' do
    before { get :new, params: slug({ data_model_id: data_model.id }) }

    it { expect(response).to render_template(:new) }
  end

  describe '#create' do
    let(:params) do
      {
        data_model_id: data_model.id,
        model_property: {
          name: 'Person',
          code: 'person'
        }
      }
    end

    before { post :create, params: slug(params) }

    context 'with valid params' do
      it { expect(response).to redirect_to([office, data_model]) }
    end

    context 'with invalid params' do
      let(:params) do
        {
          data_model_id: data_model.id,
          model_property: {
            name: 'Person',
            code: ''
          }
        }
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end

  describe '#edit' do
    before { get :edit, params: slug({ id: model_property.id }) }

    it { expect(response).to render_template(:edit) }
  end

  describe '#update' do
    let(:params) do
      {
        id: model_property.id,
        model_property: {
          name: 'Full Name'
        }
      }
    end

    before { patch :update, params: slug(params) }

    context 'with valid params' do
      it 'updates DataModel' do
        expect(response).to redirect_to([office, data_model])
        expect(model_property.reload.name).to eq('Full Name')
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          id: model_property.id,
          model_property: {
            name: 'Full Name',
            code: ''
          }
        }
      end

      it 'returns unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
