class DataModel < ApplicationRecord
  belongs_to :created_by, class_name: 'User'
  belongs_to :office

  has_many :properties, class_name: 'ModelProperty'
  has_many :instances
  has_many :templates

  def hashed_properties_fields
    properties.map { |prop| [prop.code, nil] }.to_h
  end
end
