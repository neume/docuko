class ServiceResponse
  attr_reader :status, :message, :payload

  def self.success(message:, payload: {})
    new status: 'success', message: message, payload: payload
  end

  def self.error(message:, payload: {})
    new status: 'error', message: message, payload: payload
  end

  def initialize(status:, message: nil, payload: {})
    @status = status
    @message = message
    @payload = payload
  end

  def success?
    status == 'success'
  end

  def error?
    status == 'error'
  end
end
