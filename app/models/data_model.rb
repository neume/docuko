class DataModel < ApplicationRecord
  belongs_to :created_by, class_name: 'User'
  belongs_to :office

  has_many :properties, class_name: 'ModelProperty', dependent: :destroy
  has_many :instances, dependent: :destroy
  has_many :documents, through: :instances
  has_many :templates, dependent: :destroy
  has_many :instance_properties, through: :instances, source: :properties

  accepts_nested_attributes_for :properties

  validate :no_duplicate_codes, on: :create
  validates :name, presence: true

  def no_duplicate_codes
    if properties.group_by(&:code).values.detect { |arr| arr.size > 1 }
      errors.add(:base, 'Field Code should be unique')
    end
  end
end
