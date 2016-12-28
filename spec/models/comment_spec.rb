require 'rails_helper'

describe Comment do
  let(:comment) { create(:comment) }

  it 'is valid with valid attributes' do
    expect(comment).to be_valid
  end

  describe '#user_id' do
    it 'is required' do
      comment.user_id = nil
      comment.valid?
      expect(comment.errors[:user_id].size).to eq(1)
    end
  end

  describe '#challenge_id' do
    it 'is required' do
      comment.challenge_id = nil
      comment.valid?
      expect(comment.errors[:challenge_id].size).to eq(1)
    end
  end

  describe '#body' do
    it 'is required' do
      comment.body = nil
      comment.valid?
      expect(comment.errors[:body].size).to eq(1)
    end
  end
end
