require 'rails_helper'

RSpec.describe DataModel, type: :model do
  let(:data_model) { create(:data_model) }

  describe 'no_duplicate_codes validation' do
    context 'with duplicate codes' do
      it 'fails with an error' do
        props = [
          ModelProperty.new(name: 'Name', code: 'name'),
          ModelProperty.new(name: 'Full Name', code: 'name')
        ]

        data_model = build(:data_model, properties: props)

        expect(data_model).to be_invalid
        expect(data_model.errors.first.full_message).to eq('Field Code should be unique')
      end
    end
  end
end
