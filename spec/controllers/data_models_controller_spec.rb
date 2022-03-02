require 'rails_helper'

RSpec.describe DataModelsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:data_model) { FactoryBot.create(:data_model) }

  before { user }

  describe '#index' do
    before { get :index }

    it { expect(response).to render_template(:index) }
  end

  describe '#index' do
    before { get :new }

    it { expect(response).to render_template(:new) }
  end

  describe '#create' do
    let(:params) do
      {
        data_model: {
          name: 'Person'
        }
      }
    end

    before { post :create, params: params }

    it { expect(response).to redirect_to(data_models_path) }
  end

  describe '#edit' do
    before { get :edit, params: { id: data_model.id } }

    it { expect(response).to render_template(:edit) }
  end

  describe '#update' do
    let(:params) do
      {
        id: data_model.id,
        data_model: {
          name: 'Cat'
        }
      }
    end

    before { patch :update, params: params }

    it 'updates DataModel' do
      expect(response).to redirect_to(data_models_path)
      expect(data_model.reload.name).to eq('Cat')
    end
  end
end
