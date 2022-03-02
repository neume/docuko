FactoryBot.define do
  factory :data_model do
    name { 'Person' }
    created_by { association(:user) }
    office { association(:office) }
  end
end
