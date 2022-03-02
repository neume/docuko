FactoryBot.define do
  factory :office do
    name { 'clinic' }
    sequence(:slug) { |x| "cliniko-#{x}" }
    created_by { association(:user) }
  end
end
