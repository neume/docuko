require 'rails_helper'
RSpec.describe '/offices/:office_slug/templates', type: :request do
  let(:office) { create(:office, with_user: true) }
  let(:data_model) { create(:data_model, office: office) }
  let(:valid_attributes) do
    {
      name: 'Letter',
      description: 'Welcome letter'
    }
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      template = data_model.templates.create! valid_attributes
      get office_template_url(template.id, slug)

      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_office_data_model_template_path(data_model.id, slug)
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      template = data_model.templates.create! valid_attributes
      get edit_office_template_path(template.id, slug)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Template' do
        expect do
          post office_data_model_templates_url(data_model_id: data_model.id, office_slug: office.slug),
               params: slug({ template: valid_attributes })
        end.to change(Template, :count).by(1)

        expect(response).to redirect_to(
          office_data_model_url(data_model.id, slug)
        )
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          name: 'Welcome letter'
        }
      end

      it 'updates the requested template' do
        template = data_model.templates.create! valid_attributes
        patch office_template_url(template, slug), params: { template: new_attributes }
        template.reload
        expect(template.name).to eq('Welcome letter')
        expect(response).to redirect_to(office_data_model_url(data_model, slug))
      end
    end
  end
end
