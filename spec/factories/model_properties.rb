FactoryBot.define do
  factory :model_property do
    sequence(:name) { |x| "Field #{x}" }
    sequence(:code) { |x| "code_#{x}" }
    data_model
  end
end
