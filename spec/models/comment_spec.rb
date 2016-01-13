require 'rails_helper'
require 'faker'

describe Comment do
  before(:each) do
    @user = User.create(email: Faker::Internet.email, username: Faker::Internet.user_name, password: 'password', password_confirmation: 'password')
    @challenge = @user.challenges.create(name: Faker::App.name, short_description: Faker::Lorem.sentence, long_description: Faker::Lorem.sentence, difficulty: 'easy')
  end

  describe 'validations' do
    it 'is valid with all required fields' do
      comment = @user.comments.create(challenge_id: @challenge.id, body: Faker::Lorem.sentence)
      expect(comment).to be_valid
    end

    it 'is invalid without a user_id' do
      comment = Comment.create(challenge_id: @challenge.id, body: Faker::Lorem.sentence)
      expect(comment).to_not be_valid
    end

    it 'is invalid without a challenge_id' do
      comment = @user.comments.create(challenge_id: nil, body: Faker::Lorem.sentence)
      expect(comment).to_not be_valid
    end

    it 'is invalid without a body' do
      comment = @user.comments.create(challenge_id: @challenge.id, body: nil)
      expect(comment).to_not be_valid
    end
  end
end
