FactoryGirl.define do
  factory :comment do
    content { generate :string }
    story
    user
  end
end
