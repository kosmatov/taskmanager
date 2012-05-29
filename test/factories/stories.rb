FactoryGirl.define do
  factory :story do
    content { generate :string }
    association :requester, factory: :user
    association :owner, factory: :user
  end
end
