require 'rails_helper'
require 'faker'

describe CommentsController do
  context 'user is logged in' do
    before(:each) do
      @my_user = User.create(email: Faker::Internet.email, password: 'password', password_confirmation: 'password')
      sign_in @my_user

      @my_challenge = @my_user.challenges.create(name: Faker::App.name, short_description: Faker::Hipster.sentence, long_description: Faker::Hipster.sentence, difficulty: 'easy')
    end

    describe 'POST #create' do
      it 'has a 200 status code' do
        expect(response.status).to eq(200)
      end

      context 'with valid attributes' do
        it 'saves the new comment to the database' do
          expect {
            post :create, challenge_id: @my_challenge.id, comment: {
              body: Faker::Hipster.sentence
            }
          }.to change(Comment, :count).by(1)
        end

        it 'redirects to challenge' do
          post :create, challenge_id: @my_challenge.id, comment: {
            body: Faker::Hipster.sentence }
          expect(response).to redirect_to(challenge_path(@my_challenge))
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new comment to the database' do
          expect {
            post :create, challenge_id: @my_challenge.id, comment: {
              body: nil
            }
          }.to_not change(Comment, :count)
        end
      end
    end
  end

  context 'user is logged out' do

  end
end
