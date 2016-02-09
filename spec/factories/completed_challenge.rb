FactoryGirl.define do
  factory :completed_challenge do
    user
    association :challenge, factory: [:challenge, :with_tag]
  end
end
