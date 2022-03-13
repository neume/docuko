class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :created_data_models, foreign_key: :created_by_id, inverse_of: :created_by, class_name: 'DataModel'
  has_many :created_offices, class_name: 'Office', foreign_key: :created_by_id
  has_many :members
  has_many :offices, through: :members

  validates :email, uniqueness: true
end
