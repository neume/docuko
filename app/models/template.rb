class Template < ApplicationRecord
  belongs_to :data_model

  has_one_attached :file
  has_many :documents, dependent: :nullify

  validates :name, presence: true
end
