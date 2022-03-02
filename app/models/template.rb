class Template < ApplicationRecord
  belongs_to :data_model

  has_one_attached :file
end
