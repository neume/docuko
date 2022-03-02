require 'rails_helper'

RSpec.describe ModelPropertiesController, type: :controller do
  let(:user)  { FactoryBot.create(:user) }

  let(:model_property)  { FactoryBot.create(:model_property) }
  let(:data_model) { model_property.data_model }

  before { user }

  describe '#new' do
    before { get :new, params: { data_model_id: data_model.id } }

    it { expect(response).to render_template(:new) }
  end

  describe '#create' do
    let(:params) do
      {
        data_model_id: data_model.id,
        model_property: {
          name: 'Person',
        }
      }
    end
    before { post :create, params: params }

    context 'with passing params' do
      it { expect(response).to redirect_to(data_model) }
    end
  end

  describe '#edit' do
    before { get :edit, params: { id: model_property.id } }

    it { expect(response).to render_template(:edit) }
  end

  describe '#update' do
    let(:params) do
      {
        id: model_property.id,
        model_property: {
          name: 'Full Name',
        }
      }
    end

    before { patch :update, params: params }

    it 'updates DataModel' do
      expect(response).to redirect_to(data_model)
      expect(model_property.reload.name).to eq('Full Name')
    end
  end
end
