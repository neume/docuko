class ModelProperty < ApplicationRecord
  belongs_to :data_model
  has_many :instance_properties

  validates :name, presence: true
end
