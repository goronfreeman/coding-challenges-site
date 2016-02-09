FactoryGirl.define do
  factory :comment do
    user
    association :challenge, factory: [:challenge, :with_tag]

    body Faker::Lorem.sentence
  end
end
