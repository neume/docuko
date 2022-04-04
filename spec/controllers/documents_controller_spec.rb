require 'rails_helper'

RSpec.describe DocumentsController, type: :controller do
  let(:user) { create(:user) }
  let(:office) { create(:office, created_by: user) }
  let(:instance) { InstanceCreator.create(office: office) }

  before do
    sign_in user
    allow(controller).to receive(:current_office).and_return(office)
  end

  describe '#new' do
    it 'renders new template' do
      get :new, params: slug(instance_id: instance.id), xhr: true, format: :js

      expect(response).to render_template(:new)
      expect(response).to be_successful
    end
  end

  describe '#create' do
    let(:template) { create(:template, data_model: instance.data_model) }
    let(:valid_params) do
      {
        instance_id: instance.id,
        document: {
          name: 'test',
          template_id: template.id
        }
      }
    end

    it 'creates new document' do
      expect do
        post :create, params: slug(valid_params), xhr: true, format: :js
      end.to change(instance.documents, :count).by(1)
    end
  end

  describe '#destroy_modal' do
    it 'renders destroy modal' do
      document = create(:document, instance: instance)

      get :destroy_modal, params: slug(id: document.id), xhr: true, format: :js

      expect(response).to render_template(:destroy_modal)
    end
  end

  describe '#destroy' do
    it 'deletes document' do
      document = create(:document, instance: instance)

      delete :destroy, params: slug(id: document.id)

      expect(response).to redirect_to([office, instance])
      expect(office.documents.count).to eq(0)
    end
  end
end
