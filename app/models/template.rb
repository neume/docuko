class Template < ApplicationRecord
  belongs_to :data_model

  has_one_attached :file

  validates :name, presence: true
end
