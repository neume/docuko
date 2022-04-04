FactoryBot.define do
  factory :document do
    template
    created_by { association(:user) }
    name { 'document' }
  end
end
