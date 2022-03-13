require 'rails_helper'

RSpec.describe InstancesController, type: :controller do
  let(:user) { create(:user) }
  let(:office) { create(:office, created_by: user) }
  let(:data_model) { create(:data_model, office: office) }
  let(:model_property) { create(:model_property, data_model: data_model) }

  before do
    sign_in user
    allow(controller).to receive(:current_office).and_return(office)
  end

  describe '#index' do
    before { get :index, params: slug({ data_model_id: data_model.id }) }

    it { expect(response).to render_template(:index) }
  end

  describe '#index' do
  end

  describe '#new' do
    before { get :new, params: slug({ data_model_id: data_model.id }) }

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

    before { post :create, params: slug(params) }

    context 'with passing params' do
      it { expect(response).to redirect_to([office, assigns(:instance)]) }
    end
  end

  describe '#edit' do
    let(:instance) { create(:instance, data_model: data_model) }

    before { get :edit, params: slug({ id: instance.id }) }

    it { expect(response).to render_template(:edit) }
  end
end
