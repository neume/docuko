module CreateInstanceService
  def self.create(data, data_model, user)
    instance = Instance.new data_model_name: data_model.name, data_model_id: data_model.id, created_by: user

    build_properties instance, data_model, data
    validate_properties instance
    instance.save

    instance
  end

  def self.build_properties(instance, data_model, data)
    model_properties = generate_hash_for_model_props(data_model)

    data.each do |key, value|
      next unless model_properties[key]

      instance.properties.build(
        name: model_properties[key].name,
        value: value,
        code: key,
        model_property: model_properties[key],
        required: model_properties[key].required,
        position: model_properties[key].position,
        default_value: model_properties[key].default_value
      )
    end
  end

  # TODO: extract to different service. A service should only do one thing
  def self.build_instance_properties_from_data_model(instance)
    data_model = instance.data_model

    data_model.properties.each do |model_prop|
      instance.properties.build model_prop.data_for_instance_property
    end
  end

  def self.generate_hash_for_model_props(data_model)
    data_model.properties.index_by do |prop|
      prop.code.to_s
    end
  end

  def self.validate_properties(instance)
    instance.properties.each do |prop|
      next if prop.valid?

      prop.errors.each do |error|
        next unless error.attribute == :value || error.options[:message] == :required

        instance.custom_errors.push({
                                      name: prop.name,
                                      code: prop.code,
                                      message: 'is required'
                                    })
      end
    end
  end
end
