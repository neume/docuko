require 'rails_helper'

RSpec.describe OfficesController, type: :controller do
  let(:user) { create(:user) }
  let(:office) do
    create(:office, name: 'Gameshop', created_by: user).tap do |office|
      create(:member, office: office, user: user, member_role: :admin)
    end
  end

  let(:valid_attributes) do
    {
      name: 'Mr. Tooth',
      slug: 'mr-tooth'
    }
  end

  let(:invalid_attributes) do
    {
      name: 'Mr. Tooth',
      slug: 'mr tooth with spaces'
    }
  end

  before { sign_in user }

  describe '#index' do
    context 'with search key' do
      before do
        office
        get :index, params: { search: 'Game' }
      end

      it do
        expect(assigns(:memberships).count).to eq(1)
        expect(response).to render_template(:index)
      end
    end
  end

  describe '#new' do
    before { get :new }

    it 'renders new office form' do
      expect(response).to render_template(:new)
    end
  end

  describe '#create' do
    context 'with valid params' do
      it 'creates new office' do
        expect do
          post :create, params: { office: valid_attributes }
        end.to change(Office, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'creates new office' do
        post :create, params: { office: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#show' do
    context 'with at least 1 data model' do
      it 'redirects to new data model form' do
        data_model = create(:data_model, office: office)

        get :show, params: { slug: office.slug }

        expect(office.data_models.count).to eq(1)
        expect(response).to redirect_to([office, data_model, :instances])
      end
    end

    context 'with no data model' do
      it 'redirects to new data model form' do
        get :show, params: { slug: office.slug }

        expect(response).to redirect_to([:new, office, :data_model])
      end
    end
  end

  describe '#edit' do
    before { get :edit, params: { slug: office.slug } }

    it 'renders edit office form' do
      expect(response).to render_template(:edit)
    end
  end

  describe '#update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          name: 'Tooth Saver',
          slug: 'toot-saver'
        }
      end

      it 'updates office' do
        patch :update, params: { office: new_attributes, slug: office.slug }
        office.reload
        expect(office.name).to eq('Tooth Saver')
      end
    end

    context 'with invalid params' do
      it 'creates new office' do
        patch :update, params: { office: invalid_attributes, slug: office.slug }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe '#destroy_modal' do
    it 'renders destroy modal' do
      get :destroy_modal, params: { slug: office.slug }, xhr: true, format: :js

      expect(response).to render_template(:destroy_modal)
    end
  end

  describe '#destroy' do
    it 'deletes document' do
      delete :destroy, params: { slug: office.slug }

      expect(response).to redirect_to([:offices])
      expect(user.offices.count).to eq(0)
    end
  end
end
