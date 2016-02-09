require 'rails_helper'

describe Challenge do
  it 'is valid with all required fields' do
    challenge = create(:challenge, :with_tag)

    expect(challenge).to be_valid
  end

  it 'is invalid without a user_id' do
    challenge = build(:challenge, :with_tag, user_id: nil)

    expect(challenge).to_not be_valid
  end

  it 'is invalid without a name' do
    challenge = build(:challenge, :with_tag, name: nil)

    expect(challenge).to_not be_valid
  end

  it 'is invalid without a short_description' do
    challenge = build(:challenge, :with_tag, short_description: nil)

    expect(challenge).to_not be_valid
  end

  it 'is invalid without a long_description' do
    challenge = build(:challenge, :with_tag, long_description: nil)

    expect(challenge).to_not be_valid
  end

  it 'is invalid without a difficulty' do
    challenge = build(:challenge, :with_tag, difficulty: nil)

    expect(challenge).to_not be_valid
  end

  it 'is invalid without a challenge_tag' do
    challenge = build(:challenge, :with_tag, challenge_tags_attributes: [tag_id: nil])

    expect(challenge).to_not be_valid
  end
end

describe 'associations' do
  it 'destroys dependent comments' do
    comment = build(:comment)
    challenge = Challenge.where(id: comment.challenge_id)

    expect { challenge.destroy }.to change { Comment.count }.by(-1)
  end
end
