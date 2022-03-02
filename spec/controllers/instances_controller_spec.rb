require 'rails_helper'

RSpec.describe InstancesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  let(:model_property) { FactoryBot.create(:model_property) }
  let(:data_model) { model_property.data_model }

  before { user }

  describe '#index' do
    before { get :index, params: { data_model_id: data_model.id } }

    it { expect(response).to render_template(:index) }
  end

  describe '#index' do
  end

  describe '#new' do
    before { get :new, params: { data_model_id: data_model.id } }

    it { expect(response).to render_template(:new) }
  end

  describe '#create' do
    let(:params) do
      {
        data_model_id: data_model.id,
        properties: {
          name: 'Person'
        }
      }
    end

    before { post :create, params: params }

    context 'with passing params' do
      it { expect(response).to redirect_to([data_model, :instances]) }
    end
  end

  describe '#edit' do
    before { get :edit, params: { id: model_property.id } }

    it { expect(response).to render_template(:edit) }
  end
end
