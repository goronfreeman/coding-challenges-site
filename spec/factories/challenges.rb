FactoryGirl.define do
  factory :challenge do |f|
    f.name { Faker::App.name }
    f.short_description { Faker::Hipster.sentence(3) }
    f.long_description { Faker::Hipster.sentence(8) }
  end
end
