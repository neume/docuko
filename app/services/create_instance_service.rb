module CreateInstanceService
  # TODO: extract to different service. A service should only do one thing
  def self.build_instance_properties_from_data_model(instance)
    data_model = instance.data_model

    data_model.properties.each do |model_prop|
      instance.properties.build model_prop.data_for_instance_property
    end
  end
end
