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
    context 'with search parameter' do
      it 'returns filtered data models' do
        create(:data_model, name: 'Doggo', office: office)
        get :index, params: slug({ search: 'Dog' })

        expect(assigns(:data_models).count).to eq(1)
        expect(response).to render_template(:index)
      end
    end

    context 'without data models' do
      before do
        get :index, params: slug
      end

      it 'returns filtered data models' do
        expect(response).to redirect_to([:new, office, :data_model])
      end
    end
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

    context 'with valid params' do
      it { expect(response).to redirect_to(office_data_model_path(assigns(:data_model).id, office_slug: office.slug)) }
    end

    context 'with invalid params' do
      let(:params) do
        {
          office_slug: office.slug,
          data_model: {
            name: ''
          }
        }
      end

      it { expect(response).to render_template(:new) }
    end
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

    context 'with valid params' do
      it 'updates DataModel' do
        expect(response).to redirect_to([office, assigns(:data_model)])
        expect(data_model.reload.name).to eq('Cat')
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          id: data_model.id,
          data_model: {
            name: ''
          }
        }
      end

      it { expect(response).to render_template(:edit) }
    end
  end

  describe '#show' do
    before { get :show, params: slug({ id: data_model.id }) }

    it { expect(response).to render_template(:show) }
  end

  describe '#destroy_modal' do
    it 'renders destroy modal' do
      get :destroy_modal, params: slug(id: data_model.id), xhr: true, format: :js

      expect(response).to render_template(:destroy_modal)
    end
  end

  describe '#destroy' do
    it 'deletes document' do
      delete :destroy, params: slug(id: data_model.id)

      expect(response).to redirect_to([office, :data_models])
      expect(office.data_models.count).to eq(0)
    end
  end
end
