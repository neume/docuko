class InstanceProperty < ApplicationRecord
  belongs_to :instance
  belongs_to :model_property

end
