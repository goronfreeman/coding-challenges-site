require 'rails_helper'
require 'faker'

describe CompletedChallenge do
  it 'is valid with all required fields' do
    completed_challenge = build(:completed_challenge)

    expect(completed_challenge).to be_valid
  end

  it 'requires user_id' do
    completed_challenge = build(:completed_challenge, user_id: nil)

    expect(completed_challenge).to_not be_valid
  end

  it 'requires a challenge_id' do
    completed_challenge = build(:completed_challenge, challenge_id: nil)

    expect(completed_challenge).to_not be_valid
  end
end
