FactoryBot.define do
  factory :user do
    sequence(:username) { |x| "user-#{x}" }
    password { 'password' }
  end
end
