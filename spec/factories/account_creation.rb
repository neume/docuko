class InstanceCreator
  def self.create(options = {})
    data_model = FactoryBot.create(:data_model, office: options.fetch(:office))
    FactoryBot.create(:instance, data_model: data_model)
  end
end
