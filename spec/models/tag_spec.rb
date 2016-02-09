require 'rails_helper'

describe Tag do
  it 'is valid with all required fields' do
    tag = create(:tag)

    expect(tag).to be_valid
  end

  it 'requires a name' do
    tag = build(:tag, name: nil)

    expect(tag).to_not be_valid
  end

  it 'requires name to be unique' do
    tag_one = create(:tag)
    tag_two = build(:tag, name: tag_one.name)

    expect(tag_one).to be_valid
    expect(tag_two).to_not be_valid
  end

  it 'requires tag name from list' do
    tag = build(:tag, name: Faker::App.name)

    expect(tag).to_not be_valid
  end
end
