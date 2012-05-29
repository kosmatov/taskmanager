FactoryGirl.define do
  factory :story do
    content 'My story'
    association :requester, factory: :user
    association :owner, factory: :user
  end
end
