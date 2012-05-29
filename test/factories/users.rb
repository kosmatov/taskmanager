# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
    "user-#{n}@factory.com"
  end

  sequence :name do |n|
    "user #{n}"
  end

  factory :user do
    name
    email
    password "foobar"
    password_confirmation { |u| u.password }
  end
end
