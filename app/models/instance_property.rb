class InstanceProperty < ApplicationRecord
  belongs_to :instance
  belongs_to :model_property, optional: true
end
