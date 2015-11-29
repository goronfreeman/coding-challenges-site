require 'rails_helper'

describe Challenge do
  it 'has a valid factory'

  it 'is invalid without a user_id'
    # challenge = FactoryGirl.create(:challenge)
    # expect(challenge).to_not be_valid
  # end

  it 'is invalid without a name' do
    challenge = FactoryGirl.build(:challenge, name: nil)
    expect(challenge).to_not be_valid
  end

  it 'is invalid without a short_description' do
    challenge = FactoryGirl.build(:challenge, short_description: nil)
    expect(challenge).to_not be_valid
  end

  it 'is invalid without a long_description' do
    challenge = FactoryGirl.build(:challenge, long_description: nil)
    expect(challenge).to_not be_valid
  end

  # TODO
  it 'is invalid without a difficulty'
end
