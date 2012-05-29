FactoryGirl.define do
  factory :comment do
    content 'My comment'
    story
    user
  end
end
