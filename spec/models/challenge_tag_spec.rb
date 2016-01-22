require 'rails_helper'
require 'faker'

describe ChallengeTag do
  before(:each) do
    @user = User.create(
      email: Faker::Internet.email,
      username: Faker::Internet.user_name,
      password: 'password',
      password_confirmation: 'password'
    )

    @tag = Tag.create(name: 'CSS')

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
      challenge_tag = @challenge.challenge_tags.create(tag_id: @tag.id)
      expect(challenge_tag).to be_valid
    end

    it 'is invalid without a tag_id' do
      challenge_tag = @challenge.challenge_tags.create
      expect(challenge_tag).to_not be_valid
    end
  end
end
