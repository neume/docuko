class Document < ApplicationRecord
  belongs_to :created_by, class_name: 'User'
  belongs_to :template
  belongs_to :instance
end

