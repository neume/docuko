FactoryBot.define do
  factory :document do
    instance
    template
    created_by { association(:user) }
    name { 'document' }
  end
end
