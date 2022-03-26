FactoryBot.define do
  factory :user do
    sequence(:email) { |x| "user#{x}@test" }
    password { 'password' }

    transient do
      with_office { false }
    end

    after(:create) do |user, evaluator|
      user.members.create!(office: evaluator.with_office) if evaluator.with_office
    end
  end
end
