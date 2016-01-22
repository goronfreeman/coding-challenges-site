require 'rails_helper'
require 'faker'

describe Challenge do
  before(:each) do
    @user = User.create(
      email: Faker::Internet.email,
      username: Faker::Internet.user_name,
      password: 'password',
      password_confirmation: 'password'
    )

    @my_tag = Tag.create(name: 'CSS')
  end

  describe 'validations' do
    it 'is valid with all required fields' do
      challenge = @user.challenges.create!(
        name: Faker::App.name,
        short_description: Faker::Lorem.sentence,
        long_description: Faker::Lorem.sentence,
        difficulty: 'easy',
        challenge_tags_attributes: [
          { tag_id: @my_tag.id }
        ]
      )
      expect(challenge).to be_valid
    end

    it 'is invalid without a user_id' do
      challenge = Challenge.create(
        name: Faker::App.name,
        short_description: Faker::Lorem.sentence,
        long_description: Faker::Lorem.sentence,
        difficulty: 'easy',
        challenge_tags_attributes: [
          { tag_id: @my_tag.id }
        ]
      )
      expect(challenge).to_not be_valid
    end

    it 'is invalid without a name' do
      challenge = @user.challenges.create(
        name: nil,
        short_description: Faker::Lorem.sentence,
        long_description: Faker::Lorem.sentence,
        difficulty: 'easy',
        challenge_tags_attributes: [
          { tag_id: @my_tag.id }
        ]
      )
      expect(challenge).to_not be_valid
    end

    it 'is invalid without a short_description' do
      challenge = @user.challenges.create(
        name: Faker::App.name,
        short_description: nil,
        long_description: Faker::Lorem.sentence,
        difficulty: 'easy',
        challenge_tags_attributes: [
          { tag_id: @my_tag.id }
        ]
      )
      expect(challenge).to_not be_valid
    end

    it 'is invalid without a long_description' do
      challenge = @user.challenges.create(
        name: Faker::App.name,
        short_description: Faker::Lorem.sentence,
        long_description: nil,
        challenge_tags_attributes: [
          { tag_id: @my_tag.id }
        ]
      )
      expect(challenge).to_not be_valid
    end

    it 'is invalid without a difficulty' do
      challenge = @user.challenges.create(
        name: Faker::App.name,
        short_description: Faker::Lorem.sentence,
        long_description: Faker::Lorem.sentence,
        difficulty: nil,
        challenge_tags_attributes: [
          { tag_id: @my_tag.id }
        ]
      )
      expect(challenge).to_not be_valid
    end

    it 'is invalid without a challenge_tag' do
      challenge = @user.challenges.create(
        name: Faker::App.name,
        short_description: Faker::Lorem.sentence,
        long_description: Faker::Lorem.sentence,
        difficulty: 'easy',
        challenge_tags_attributes: [
          { tag_id: nil }
        ]
      )
      expect(challenge).to_not be_valid
    end
  end

  describe 'associations' do
    it 'destroys dependent comments' do
      challenge = @user.challenges.create!(
        name: Faker::App.name,
        short_description: Faker::Lorem.sentence,
        long_description: Faker::Lorem.sentence,
        difficulty: 'easy',
        challenge_tags_attributes: [
          { tag_id: @my_tag.id }
        ]
      )

      @user.comments.create!(
        body: Faker::Lorem.sentence,
        challenge_id: challenge.id,
        user_id: @user.id
      )

      expect { challenge.destroy }.to change { Comment.count }.by(-1)
    end
  end
end
