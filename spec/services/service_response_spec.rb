require 'rails_helper'

RSpec.describe ServiceResponse do
  describe '.success' do
    it 'returns a successful service response' do
      message = 'Service finished successfully'
      payload = { data: 'Hello world' }

      service_response = described_class.success message: message, payload: payload

      expect(service_response).to be_success
      expect(service_response.message).to eq('Service finished successfully')
      expect(service_response.payload).to eq({ data: 'Hello world' })
    end
  end

  describe '.errors' do
    it 'returns a successful service response' do
      message = 'Something went wrong'
      payload = { data: 'Hello world' }

      service_response = described_class.error message: message, payload: payload

      expect(service_response).to be_error
      expect(service_response.message).to eq('Something went wrong')
      expect(service_response.payload).to eq({ data: 'Hello world' })
    end
  end

  describe '[]' do
    it "returns payload's hash" do
      message = 'Something went wrong'
      payload = { data: 'Hello world' }

      service_response = described_class.error message: message, payload: payload

      expect(service_response[:data]).to eq('Hello world')
    end
  end
end
