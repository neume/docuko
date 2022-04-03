require 'rails_helper'

RSpec.describe Instances::CreateService do
  let(:data_model) do
    data_model = create(:data_model)
    create(:model_property, data_model: data_model, name: 'Username', code: 'username', required: true)
    data_model.reload
  end
  let(:user) { create(:user) }

  describe '.execute' do
    context 'with valid paramaters' do
      let(:data) do
        HashWithIndifferentAccess.new ({
          username: 'cardo'
        })
      end

      it 'creates an instance' do
        result = described_class.execute data, data_model, user

        expect(result).to be_success
        expect(result.payload[:instance].properties.count).to eq(1)
      end
    end

    context 'with invalid paramteres' do
      let(:data) do
        HashWithIndifferentAccess.new ({
          username: nil
        })
      end

      it 'returns an error' do
        result = described_class.execute data, data_model, user
        instance = result.payload[:instance]

        expect(instance.errors.first.full_message).to eq("Username is required")
        expect(result).to be_error
      end
    end
  end
end
