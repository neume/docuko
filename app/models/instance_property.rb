class InstanceProperty < ApplicationRecord
  belongs_to :instance
  belongs_to :model_property, optional: true

  # validates :value, presence: true, if: proc { |prop| prop.required? }
  validate :presence_of_value

  def presence_of_value
    return true unless required

    errors.add(:base, "#{name} is required") if value.nil? || value.empty?
  end
end
