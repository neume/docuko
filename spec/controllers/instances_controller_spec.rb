require 'rails_helper'

RSpec.describe InstancesController, type: :controller do
  let(:user) { create(:user) }
  let(:office) { create(:office, created_by: user) }
  let(:data_model) { create(:data_model, office: office) }
  let(:model_property) { create(:model_property, data_model: data_model, required: true) }

  before do
    sign_in user
    allow(controller).to receive(:current_office).and_return(office)
  end

  describe '#index' do
    context 'with search params' do
      before do
        instance = create(:instance, data_model: data_model)
        create(:instance_property, instance: instance, model_property: model_property, value: 'Cardo')
        get :index, params: slug({ data_model_id: data_model.id, search: 'Cardo' })
      end

      it { expect(assigns(:instances).count).to eq(1) }
    end

    context 'without search params' do
      before { get :index, params: slug({ data_model_id: data_model.id }) }

      it { expect(response).to render_template(:index) }
    end
  end

  describe '#new' do
    before { get :new, params: slug({ data_model_id: data_model.id }) }

    it { expect(response).to render_template(:new) }
  end

  describe '#create' do
    before do
      create(:model_property, name: 'Full name', code: 'name', required: true, data_model: data_model)
      post :create, params: slug(params)
    end

    context 'with valid params' do
      let(:params) do
        {
          data_model_id: data_model.id,
          properties: {
            name: 'Person'
          }
        }
      end

      it { expect(response).to redirect_to([office, assigns(:instance)]) }
    end

    context 'with invalid params' do
      let(:params) do
        {
          data_model_id: data_model.id,
          properties: {
            name: ''
          }
        }
      end

      it { expect(response).to render_template(:new) }
    end
  end

  describe '#edit' do
    let(:instance) { create(:instance, data_model: data_model) }

    before { get :edit, params: slug({ id: instance.id }) }

    it { expect(response).to render_template(:edit) }
  end

  describe '#show' do
    let(:instance) { create(:instance, data_model: data_model) }

    before { get :show, params: slug({ id: instance.id }) }

    it { expect(response).to render_template(:show) }
  end
end
