FactoryBot.define do
  factory :instance_property do
    field_name { "MyString" }
    value { "MyString" }
    instance { association(:instance) }
    data_property { association(:model_property) }
  end
end
