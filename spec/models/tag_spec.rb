require 'rails_helper'
require 'faker'

describe Tag do
  describe 'validations' do
    it 'is valid with all required fields' do
      tag = Tag.create(name: 'css')
      expect(tag).to be_valid
    end

    it 'is invalid without a name' do
      tag = Tag.create(name: nil)
      expect(tag).to_not be_valid
    end

    it 'is invalid without a unique name' do
      tag_one = Tag.create(name: 'php')
      tag_two = Tag.create(name: tag_one.name)
      expect(tag_one).to be_valid
      expect(tag_two).to_not be_valid
    end

    it 'is invalid without a tag name from list' do
      tag = Tag.create(name: Faker::App.name)
      expect(tag).to_not be_valid
    end
  end
end
