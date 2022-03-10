require 'rails_helper'

RSpec.describe CreateDocumentService do
  describe '.create' do
    let(:user) { create(:user) }
    let(:office) { create(:office) }
    let(:data_model) { create(:data_model, office: office) }
    let(:template) { create(:template, data_model: data_model) }
    let(:instance) { create(:instance) }
    let(:document_params) do
      {
        name: 'Test file',
        template_id: template.id
      }
    end

    before do
      create(:instance_property, value: 'Docuko Project', field_name: 'project', instance: instance)
      create(:instance_property, value: 'January 1, 2022', field_name: 'date', instance: instance)
    end

    it 'creates document' do
      document = described_class.create(params: document_params, instance: instance, office: office, user: user)

      expect(document).to be_persisted
    end
  end

  describe '.generate_document' do
    let(:context) do
      {
        project_name: 'project_name',
        date: 'January 1, 2022'
      }
    end
    let(:template) do
      File.join(Rails.root, 'spec', 'fixtures', 'files', 'project.docx')
    end

    it 'creates document' do
      rendered_doc = described_class.generate context: context, template: template

      expect(rendered_doc.size).not_to be_zero
    end
  end
end
