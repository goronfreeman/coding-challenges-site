require 'rails_helper'
require 'faker'

describe CompletedChallenge do
  before(:each) do
    @user = User.create(
      email: Faker::Internet.email,
      username: Faker::Internet.user_name,
      password: 'password',
      password_confirmation: 'password'
    )

    @tag = Tag.create(name: 'css')

    @challenge = @user.challenges.create!(
      name: Faker::App.name,
      short_description: Faker::Lorem.sentence,
      long_description: Faker::Lorem.sentence,
      difficulty: 'easy',
      challenge_tags_attributes: [
        { tag_id: @tag.id }
      ]
    )
  end

  describe 'validations' do
    it 'is valid with all required fields' do
      completed_challenge = CompletedChallenge.create(
        user_id: @user.id,
        challenge_id: @challenge.id
      )

      expect(completed_challenge).to be_valid
    end

    it 'is invalid without a user_id' do
      completed_challenge = CompletedChallenge.create(
        challenge_id: @challenge.id
      )

      expect(completed_challenge).to_not be_valid
    end

    it 'is invalid without a challenge_id' do
      completed_challenge = CompletedChallenge.create(user_id: @user.id)
      expect(completed_challenge).to_not be_valid
    end
  end
end
