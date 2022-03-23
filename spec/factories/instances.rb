FactoryBot.define do
  factory :instance do
    data_model
    created_by { association :user }
  end
end
