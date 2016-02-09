FactoryGirl.define do
  sequence :email do
    Faker::Internet.email
  end

  factory :user do
    email
    username Faker::Internet.user_name
    password 'password'
    password_confirmation 'password'
  end
end
