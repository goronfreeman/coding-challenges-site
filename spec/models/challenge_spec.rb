require 'rails_helper'
require 'faker'

describe Challenge do
  before(:each) do
    @user = User.create(email: Faker::Internet.email, username: Faker::Internet.user_name, password: 'password', password_confirmation: 'password')
  end

  describe 'validations' do
    it 'is valid with all required fields' do
      challenge = @user.challenges.create!(name: Faker::App.name, short_description: Faker::Lorem.sentence, long_description: Faker::Lorem.sentence, difficulty: 'easy' )
      expect(challenge).to be_valid
    end

    it 'is invalid without a user_id' do
      challenge = Challenge.create(name: Faker::App.name, short_description: Faker::Lorem.sentence, long_description: Faker::Lorem.sentence, difficulty: 'easy')
      expect(challenge).to_not be_valid
    end

    it 'is invalid without a name' do
      challenge = @user.challenges.create(name: nil, short_description: Faker::Lorem.sentence, long_description: Faker::Lorem.sentence, difficulty: 'easy')
      expect(challenge).to_not be_valid
    end

    it 'is invalid without a short_description' do
      challenge = @user.challenges.create(name: Faker::App.name, short_description: nil, long_description: Faker::Lorem.sentence, difficulty: 'easy')
      expect(challenge).to_not be_valid
    end

    it 'is invalid without a long_description' do
      challenge = @user.challenges.create(name: Faker::App.name, short_description: Faker::Lorem.sentence, long_description: nil)
      expect(challenge).to_not be_valid
    end

    it 'is invalid without a difficulty' do
      challenge = @user.challenges.create(name: Faker::App.name, short_description: Faker::Lorem.sentence, long_description: Faker::Lorem.sentence, difficulty: nil)
      expect(challenge).to_not be_valid
    end
  end

  describe 'associations' do
    it 'destroys dependent comments' do
      challenge = @user.challenges.create!(name: Faker::App.name, short_description: Faker::Lorem.sentence, long_description: Faker::Lorem.sentence, difficulty: 'easy' )
      comment = @user.comments.create!(body: Faker::Lorem.sentence, challenge_id: challenge.id, user_id: @user.id)

      expect { challenge.destroy }.to change { Comment.count }.by(-1)
    end
  end
end
