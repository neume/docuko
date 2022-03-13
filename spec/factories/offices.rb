FactoryBot.define do
  factory :office do
    transient do
      with_user { false }
      member_role { :regular }
    end

    name { 'clinic' }
    sequence(:slug) { |x| "cliniko-#{x}" }
    created_by { association(:user) }

    after(:create) do |office, evaluator|
      office.members.create(user: office.created_by, member_role: evaluator.member_role) if evaluator.with_user
    end
  end
end
