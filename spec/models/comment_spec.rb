require 'rails_helper'

describe Comment do
  it 'is valid with all required fields' do
    comment = build(:comment)

    expect(comment).to be_valid
  end

  it 'requires a user_id' do
    comment = build(:comment, user_id: nil)

    expect(comment).to_not be_valid
  end

  it 'requires a challenge_id' do
    comment = build(:comment, challenge_id: nil)

    expect(comment).to_not be_valid
  end

  it 'requires a body' do
    comment = build(:comment, body: nil)

    expect(comment).to_not be_valid
  end
end
