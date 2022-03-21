class Office < ApplicationRecord
  has_many :data_models, dependent: :destroy
  has_many :templates, through: :data_models
  has_many :instances, through: :data_models
  has_many :model_properties, through: :data_models, source: :properties
  has_many :instance_properties, through: :instances, source: :properties
  has_many :members, dependent: :destroy
  has_many :users, through: :members
  has_many :documents, through: :instances
  belongs_to :created_by, class_name: 'User'

  validates :slug, format: { with: /\A[a-zA-Z0-9-]+\Z/ }, uniqueness: true

  def to_param
    slug
  end
end
