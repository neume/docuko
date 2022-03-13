class ModelProperty < ApplicationRecord
  belongs_to :data_model
  has_many :instance_properties, dependent: :nullify

  validates :name, presence: true
  validates :code, uniqueness: { scoped: :data_model }, presence: true,
                   format: {
                     with: /\A[a-zA-Z0-9_]+\z/,
                     message: 'only allows a-z, A-Z and 0-9 and underscore'
                   }
end
