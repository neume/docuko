FactoryBot.define do
  factory :user do
    sequence(:email) { |x| "user#{x}@test" }
    password { 'password' }
  end
end
