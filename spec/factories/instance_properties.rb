FactoryBot.define do
  factory :instance_property do
    field_name { 'MyString' }
    value { 'MyString' }
    instance { association(:instance) }
    model_property
  end
end
