module CreateInstanceService
  def self.create(data, data_model)
    instance = Instance.new data_model_name: data_model.name, data_model_id: data_model.id

    build_properties instance, data_model, data
    instance.save

    instance
  end

  def self.build_properties(instance, data_model, data)
    model_properties = generate_hash_for_model_props(data_model)

    data.each do |key, value|
      next unless model_properties[key]

      instance.properties.build(
        field_name: model_properties[key].name,
        value: value,
        code: key,
        model_property: model_properties[key]
      )
    end
  end

  def self.generate_hash_for_model_props(data_model)
    data_model.properties.index_by do |prop|
      prop.code.to_s
    end
  end
end
