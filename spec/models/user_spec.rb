require 'rails_helper'
require 'faker'

describe User do
  describe 'validations' do
    it 'is valid with all required fields' do
      user = User.create(
        email: Faker::Internet.email,
        username: Faker::Internet.user_name,
        password: 'password',
        password_confirmation: 'password'
      )

      expect(user).to be_valid
    end

    it 'is invalid without a username' do
      user = User.create(
        email: Faker::Internet.email,
        username: nil,
        password: 'password',
        password_confirmation: 'password'
      )

      expect(user).to be_invalid
    end

    it 'accepts valid image url' do
      user = User.create(
        email: Faker::Internet.email,
        username: Faker::Internet.user_name,
        password: 'password',
        password_confirmation: 'password',
        image: 'https://avatars3.githubusercontent.com/u/5210483?v=3&s=460'
      )

      expect(user).to be_valid
      expect(user.image).to_not be_nil
    end

    it 'converts blank image url to nil' do
      user = User.create(
        email: Faker::Internet.email,
        username: Faker::Internet.user_name,
        password: 'password',
        password_confirmation: 'password',
        image: ''
      )

      expect(user.image).to be_nil
    end
  end
end
