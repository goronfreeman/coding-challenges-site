require 'rails_helper'

describe User do
  let(:user) { create(:user) }

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  describe '#username' do
    it 'is required' do
      user.username = nil
      user.valid?
      expect(user.errors[:username].size).to eq(1)
    end

    it 'is unique' do
      another_user = build(:user, username: user.username)
      another_user.valid?
      expect(another_user.errors[:username].size).to eq(1)
    end
  end

  describe '#image' do
    it 'is accepted' do
      user.image = 'https://avatars3.githubusercontent.com/u/5210483?v=3&s=460'
      expect(user).to be_valid
      expect(user.image).to_not be_nil
    end

    it 'converts blank string to nil' do
      user = create(:user, image: '')
      expect(user.image).to be_nil
    end
  end
end
