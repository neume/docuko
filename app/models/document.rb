class Document < ApplicationRecord
  serialize :context, Hash

  belongs_to :created_by, class_name: 'User'
  belongs_to :template
  belongs_to :instance

  has_one_attached :file

  def template_name
    template&.name || 'Deleted'
  end
end
