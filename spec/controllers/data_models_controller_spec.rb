require 'rails_helper'

RSpec.describe DataModelsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:office) { FactoryBot.create(:office, created_by: user) }
  let(:data_model) { FactoryBot.create(:data_model, office: office) }

  before do
    sign_in user
    allow(controller).to receive(:authorize_admin!).and_return(true)
    allow(controller).to receive(:current_office).and_return(office)
  end

  describe '#index' do
    before { get :index, params: slug }

    it { expect(response).to render_template(:index) }
  end

  describe '#new' do
    before { get :new, params: slug }

    it { expect(response).to render_template(:new) }
  end

  describe '#create' do
    let(:params) do
      {
        office_slug: office.slug,
        data_model: {
          name: 'Person'
        }
      }
    end

    before { post :create, params: params }

    it { expect(response).to redirect_to(office_data_model_path(assigns(:data_model).id, office_slug: office.slug)) }
  end

  describe '#edit' do
    before { get :edit, params: slug({ id: data_model.id }) }

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

    before { patch :update, params: slug(params) }

    it 'updates DataModel' do
      expect(response).to redirect_to([office, assigns(:data_model)])
      expect(data_model.reload.name).to eq('Cat')
    end
  end
end
