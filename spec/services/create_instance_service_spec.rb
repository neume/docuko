require 'rails_helper'

RSpec.describe CreateInstanceService do
  let(:user) { create(:user) }
  let(:data_model) do
    data_model = create(:data_model)

    properties = [
      { name: 'First Name', code: 'first_name', data_model_id: data_model.id },
      { name: 'Last Name', code: 'last_name', data_model_id: data_model.id }
    ]

    data_model.properties.create(properties)
    data_model
  end

  it 'creates instance of data model' do
    instance_params = HashWithIndifferentAccess.new(
      first_name: 'Juan',
      last_name: 'Dela Cruz'
    )

    instance = described_class.create(instance_params, data_model, user)

    expect(instance).to be_persisted
    expect(instance.properties.pluck(:value)).to eq(['Juan', 'Dela Cruz'])
  end
end
