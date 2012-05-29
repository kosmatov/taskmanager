FactoryGirl.define do
  factory :user do
    name "Key Kosmatov"
    email "key@kosmatov.su"
    password "foobar"
    password_confirmation "foobar"
  end

  sequence :email do |n|
    "person-#{n}@example.com"
  end

  factory :story do
    content "Foo bar"
    user
    association :owner, :factory => :user
  end
end

