class Instance < ApplicationRecord
  has_many :properties, class_name: 'InstanceProperty', dependent: :destroy, autosave: true
  has_many :documents, dependent: :destroy
  belongs_to :data_model

  def hashed_properties
    properties.each_with_object({}) do |prop, hash|
      hash[prop.code] = prop.value
    end
  end

  def custom_errors
    @custom_errors ||= []
  end
end
