require 'rails_helper'

describe User do
  it 'is valid with all required fields' do
    user = create(:user)

    expect(user).to be_valid
  end

  it 'requires a username' do
    user = build(:user, username: nil)

    expect(user).to be_invalid
  end

  it 'accepts valid image url' do
    user = create(:user, image: 'https://avatars3.githubusercontent.com/u/5210483?v=3&s=460')

    expect(user).to be_valid
    expect(user.image).to_not be_nil
  end

  it 'converts blank image url to nil' do
    user = create(:user, image: '')

    expect(user.image).to be_nil
  end
end
