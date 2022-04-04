require 'rails_helper'

RSpec.describe Document, type: :model do
  let(:template) { create(:template, name: 'project') }
  let(:document) { create(:document, template: template) }

  describe '#template_name' do
    context 'with template' do
      it { expect(document.template_name).to eq('project') }
    end

    context 'with destroyed template' do
      before do
        template.destroy
        document.reload
      end

      it { expect(document.template_name).to eq('Deleted') }
    end
  end
end
