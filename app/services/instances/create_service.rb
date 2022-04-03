class Instances::CreateService
  def self.execute(data, data_model, user)
    new(data, data_model, user).execute
  end

  attr_reader :data, :data_model, :user, :instance

  def initialize(data, data_model, user)
    @data = data
    @data_model = data_model
    @user = user
  end

  def execute
    @instance = build_instance
    # validate_properties

    if instance.save
      ServiceResponse.success message: 'Instance created', payload: { instance: instance }
    else
      ServiceResponse.error  message: 'An error occured creating instance', payload: { instance: instance }
    end
  end

  private

  def build_instance
    Instance.new data_model_name: data_model.name,
                 data_model_id: data_model.id,
                 created_by: user,
                 properties: properties_data
  end

  def properties_data
    model_properties = generate_hash_for_model_props
    properties = []

    data.each do |key, value|
      next unless model_properties[key]
      properties << InstanceProperty.new(
        name: model_properties[key].name,
        value: value,
        code: key,
        model_property: model_properties[key],
        required: model_properties[key].required,
        position: model_properties[key].position,
        default_value: model_properties[key].default_value
      )
    end

    properties
  end

  # def build_properties

  #   data.each do |key, value|
  #     next unless model_properties[key]

  #     instance.properties.build(
  #       name: model_properties[key].name,
  #       value: value,
  #       code: key,
  #       model_property: model_properties[key],
  #       required: model_properties[key].required,
  #       position: model_properties[key].position,
  #       default_value: model_properties[key].default_value
  #     )
  #   end
  # end

  def generate_hash_for_model_props
    data_model.properties.index_by do |prop|
      prop.code.to_s
    end
  end

  # def validate_properties
  #   instance.properties.each do |prop|
  #     next if prop.valid?

  #     prop.errors.each do |error|
  #       next unless error.attribute == :value || error.options[:message] == :required

  #       instance.add_custom_error(name: prop.name, code: prop.code, message: 'is required')
  #     end
  #   end
  # end
end
