require 'rails_helper'

RSpec.describe Instance, type: :model do
  let(:instance) { create(:instance) }

  describe '#hashed_properties' do
    before do
      create(:instance_property, code: 'name', value: 'Juan', instance: instance)
      create(:instance_property, code: 'age', value: '25', instance: instance)
    end

    it 'returns hashed properties' do
      properties = instance.hashed_properties
      expected = {
        'name' => 'Juan',
        'age' => '25'
      }

      expect(properties).to eq(expected)
    end
  end
end
