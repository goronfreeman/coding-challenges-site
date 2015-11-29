FactoryGirl.define do
  factory :challenge do
    name { Faker::App.name }
    short_description { Faker::Hipster.sentence(3) }
    long_description { Faker::Hipster.sentence(8) }
  end
end
