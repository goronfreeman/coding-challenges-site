require 'rails_helper'

describe Challenge do
  let(:challenge) { create(:challenge, :with_tag) }

  it 'is valid with valid attributes' do
    expect(challenge).to be_valid
  end

  describe '#user_id' do
    it 'is required' do
      challenge.user_id = nil
      challenge.valid?
      expect(challenge.errors[:user_id].size).to eq(1)
    end
  end

  describe '#name' do
    it 'is required' do
      challenge.name = nil
      challenge.valid?
      expect(challenge.errors[:name].size).to eq(1)
    end

    it 'is unique' do
      another_challenge = build(:challenge, name: challenge.name)
      another_challenge.valid?
      expect(another_challenge.errors[:name].size).to eq(1)
    end
  end

  describe '#short_description' do
    it 'is required' do
      challenge.short_description = nil
      challenge.valid?
      expect(challenge.errors[:short_description].size).to eq(1)
    end

    it 'is unique' do
      another_challenge = build(:challenge, short_description: challenge.short_description)
      another_challenge.valid?
      expect(another_challenge.errors[:short_description].size).to eq(1)
    end
  end

  describe '#long_description' do
    it 'is required' do
      challenge.long_description = nil
      challenge.valid?
      expect(challenge.errors[:long_description].size).to eq(1)
    end

    it 'is unique' do
      another_challenge = build(:challenge, long_description: challenge.long_description)
      another_challenge.valid?
      expect(another_challenge.errors[:long_description].size).to eq(1)
    end
  end

  describe '#difficulty' do
    it 'is required' do
      challenge.difficulty = nil
      challenge.valid?
      expect(challenge.errors[:difficulty].size).to eq(1)
    end
  end

  describe '#challenge_tags' do
    it 'is required' do
      challenge.challenge_tags = []
      challenge.valid?
      expect(challenge.errors[:challenge_tags].size).to eq(1)
    end
  end

  it 'destroys dependent comments' do
    comment = create(:comment)
    challenge = Challenge.find(comment.challenge_id)
    expect { challenge.destroy }.to change { Comment.count }.by(-1)
  end
end
