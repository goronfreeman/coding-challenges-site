require 'rails_helper'

describe CompletedChallenge do
  let(:completed_challenge) { create(:completed_challenge) }

  it 'is valid with valid attributes' do
    expect(completed_challenge).to be_valid
  end

  describe '#user_id' do
    it 'is required' do
      completed_challenge.user_id = nil
      completed_challenge.valid?
      expect(completed_challenge.errors[:user_id].size).to eq(1)
    end
  end

  describe '#challenge_id' do
    it 'is required' do
      completed_challenge.challenge_id = nil
      completed_challenge.valid?
      expect(completed_challenge.errors[:challenge_id].size).to eq(1)
    end
  end
end
