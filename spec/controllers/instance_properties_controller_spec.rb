require 'rails_helper'

RSpec.describe InstancePropertiesController, type: :controller do
  let(:user) { create(:user) }
  let(:office) { create(:office, created_by: user) }
  let(:instance_property) do
    data_model = create(:data_model, office: office)
    instance = create(:instance, data_model: data_model)
    create(:instance_property, instance: instance, value: 'First value')
  end

  before do
    sign_in user
    allow(controller).to receive(:current_office).and_return(office)
  end

  describe '#edit' do
    before do
      get :edit, params: slug(id: instance_property.id), xhr: true, format: :js
    end

    it 'renders edit template' do
      expect(response).to render_template(:edit)
    end
  end

  describe '#update' do
    let(:valid_params) do
      {
        id: instance_property.id,
        instance_property: {
          value: 'Second value'
        }
      }
    end

    before do
      patch :update, params: slug(valid_params), xhr: true, format: :js
    end

    it 'updates instance property' do
      instance_property.reload

      expect(instance_property.value).to eq('Second value')
      expect(response).to render_template(:update)
    end
  end
end
