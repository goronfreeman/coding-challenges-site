FactoryGirl.define do
  factory :tag do
    name 'css'
  end

  factory :challenge do
    user

    name Faker::App.name
    short_description Faker::Lorem.sentence
    long_description Faker::Lorem.sentence
    difficulty 'easy'

    trait :with_tag do
      before(:create) do |challenge|
        challenge.tags << create(:tag)
      end
    end
  end
end
