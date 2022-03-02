FactoryBot.define do
  factory :document do
    created_by_id { '' }
    form_id { '' }
    data_model_id { '' }
    version { 'MyString' }
    name { 'MyString' }
    context { 'MyText' }
  end
end
