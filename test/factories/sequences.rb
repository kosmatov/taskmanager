FactoryGirl.define do
  sequence :integer do |n|
    n
  end

  sequence :string do |n|
    "string-#{n}"
  end

  sequence :email do |n|
    "email-#{n}@example.com"
  end
end
