require 'rails_helper'
require 'faker'

describe CompletedChallenge do
  before(:each) do
    @user = User.create(email: Faker::Internet.email, password: 'password', password_confirmation: 'password')
    @challenge = @user.challenges.create!(name: Faker::App.name, short_description: Faker::Hipster.sentence, long_description: Faker::Hipster.sentence)
  end

  describe 'validations' do
    it 'is valid with all required fields' do
      completed_challenge = CompletedChallenge.create(user_id: @user.id, challenge_id: @challenge.id)
      expect(completed_challenge).to be_valid
    end

    it 'is invalid without a user_id' do
      completed_challenge = CompletedChallenge.create(challenge_id: @challenge.id)
      expect(completed_challenge).to_not be_valid
    end

    it 'is invalid without a challenge_id' do
      completed_challenge = CompletedChallenge.create(user_id: @user.id)
      expect(completed_challenge).to_not be_valid
    end
  end
end