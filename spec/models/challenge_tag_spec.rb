require 'rails_helper'
require 'faker'

describe ChallengeTag do
  before(:each) do
    @user = User.create(email: Faker::Internet.email, password: 'password', password_confirmation: 'password')
    @challenge = @user.challenges.create!(name: Faker::App.name, short_description: Faker::Hipster.sentence, long_description: Faker::Hipster.sentence, difficulty: 'easy')
    @tag = Tag.create(name: 'CSS')
  end

  describe 'validations' do
    it 'is valid with all required fields' do
      challenge_tag = ChallengeTag.create(challenge_id: @challenge.id, tag_id: @tag.id)
      expect(challenge_tag).to be_valid
    end

    it 'is invalid without a challenge_id' do
      challenge_tag = ChallengeTag.create(tag_id: @tag.id)
      expect(challenge_tag).to_not be_valid
    end

    it 'is invalid without a tag_id' do
      challenge_tag = ChallengeTag.create(challenge_id: @challenge.id)
      expect(challenge_tag).to_not be_valid
    end
  end
end
