class DataModel < ApplicationRecord
  belongs_to :created_by, class_name: 'User'
  belongs_to :office

  has_many :properties, class_name: 'ModelProperty', dependent: :destroy
  has_many :instances, dependent: :destroy
  has_many :documents, through: :instances
  has_many :templates, dependent: :destroy
  has_many :instance_properties, through: :instances, source: :properties
end
