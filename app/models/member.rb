class Member < ApplicationRecord
  enum member_status: { active: 1, inactive: 0 }
  enum member_role: { admin: 1, regular: 2 }
  belongs_to :user
  belongs_to :office
end
