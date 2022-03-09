require 'rails_helper'

RSpec.describe DocumentsController, type: :controller do
  let(:user) { create(:user) }
  let(:office) { create(:office, created_by: user) }
  let(:data_model) { create(:data_model, office: office) }
  let(:instance) { create(:instance, data_model: data_model ) }
  let(:template) { create(:template, data_model: data_model ) }

  describe '#new' do
    it 'renders new template' do
      get :new, params: slug(instance_id: instance.id), xhr: true, format: :js

      expect(response).to render_template(:new)
      expect(response).to be_successful
    end
  end

  describe '#create' do
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
end
