require 'rails_helper'
require 'faker'

describe Challenge do
  before(:each) do
    @user = User.create(email: Faker::Internet.email, password: 'password', password_confirmation: 'password')
  end

  describe 'validations' do
    it 'is valid with all required fields' do
      challenge = @user.challenges.create!(name: Faker::App.name, short_description: Faker::Hipster.sentence, long_description: Faker::Hipster.sentence, difficulty: 'easy' )
      expect(challenge).to be_valid
    end

    it 'is invalid without a user_id' do
      challenge = Challenge.create(name: Faker::App.name, short_description: Faker::Hipster.sentence, long_description: Faker::Hipster.sentence, difficulty: 'easy')
      expect(challenge).to_not be_valid
    end

    it 'is invalid without a name' do
      challenge = @user.challenges.create(name: nil, short_description: Faker::Hipster.sentence, long_description: Faker::Hipster.sentence, difficulty: 'easy')
      expect(challenge).to_not be_valid
    end

    it 'is invalid without a short_description' do
      challenge = @user.challenges.create(name: Faker::App.name, short_description: nil, long_description: Faker::Hipster.sentence, difficulty: 'easy')
      expect(challenge).to_not be_valid
    end

    it 'is invalid without a long_description' do
      challenge = @user.challenges.create(name: Faker::App.name, short_description: Faker::Hipster.sentence, long_description: nil)
      expect(challenge).to_not be_valid
    end

    it 'is invalid without a difficulty' do
      challenge = @user.challenges.create(name: Faker::App.name, short_description: Faker::Hipster.sentence, long_description: Faker::Hipster.sentence, difficulty: nil)
      expect(challenge).to_not be_valid
    end
  end
end
