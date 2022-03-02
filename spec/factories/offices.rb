FactoryBot.define do
  factory :office do
    name { 'clinic' }
    slug { 'cliniko' }
    created_by { association(:user) }
  end
end
