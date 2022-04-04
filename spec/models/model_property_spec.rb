require 'rails_helper'

RSpec.describe ModelProperty, type: :model do
  describe '#data_for_instance_property' do
    let(:model_property) { create(:model_property, name: 'Age', default_value: '18') }

    it { expect(model_property.data_for_instance_property[:value]).to eq('18') }
  end
end
