require 'rails_helper'

describe Tag do
  let(:tag) { create(:tag) }

  it 'is valid with valid attributes' do
    expect(tag).to be_valid
  end

  describe '#name' do
    it 'is required' do
      tag.name = nil
      tag.valid?
      expect(tag.errors[:name].size).to eq(2)
    end

    it 'is unique' do
      another_tag = build(:tag, name: tag.name)
      another_tag.valid?
      expect(another_tag.errors[:name].size).to eq(1)
    end

    it 'is included in list' do
      another_tag = build(:tag, name: 'wrong')
      another_tag.valid?
      expect(another_tag.errors[:name].size).to eq(1)
    end
  end

  it 'destroys dependent challenge_tags' do
    challenge = create(:challenge, :with_tag)
    tag = Tag.find(challenge.tag_ids)

    expect { tag.each(&:destroy) }.to change { ChallengeTag.count }.by(-1)
  end
end
