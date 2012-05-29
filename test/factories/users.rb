FactoryGirl.define do
  factory :user do
    name { generate :string }
    email
    password { generate :string }
    password_confirmation { |u| u.password }
  end
end
