class Instance < ApplicationRecord
  has_many :properties, class_name: 'InstanceProperty'
  has_many :documents
  belongs_to :data_model

  def hashed_properties
    properties.each_with_object({}) do |prop, hash|
      hash[prop.code] = prop.value
    end
  end
end
