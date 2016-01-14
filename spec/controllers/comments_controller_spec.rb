require 'rails_helper'
require 'faker'

describe CommentsController do
  context 'user is logged in' do
    before(:each) do
      @my_user = User.create(email: Faker::Internet.email, username: Faker::Internet.user_name, password: 'password', password_confirmation: 'password')
      sign_in @my_user
      @my_challenge = @my_user.challenges.create(name: Faker::App.name, short_description: Faker::Lorem.sentence, long_description: Faker::Lorem.sentence, difficulty: 'easy')
    end

    describe 'POST #create' do
      it 'has a 200 status code' do
        expect(response.status).to eq(200)
      end

      context 'with valid attributes' do
        it 'saves the new comment to the database' do
          expect {
            post :create, challenge_id: @my_challenge.id, comment: {
              body: Faker::Lorem.sentence
            }
          }.to change(Comment, :count).by(1)
        end

        it 'redirects to challenge' do
          post :create, challenge_id: @my_challenge.id, comment: {
            body: Faker::Lorem.sentence }
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

    describe 'GET #edit' do
      before(:each) do
        @my_comment = @my_user.comments.create(challenge_id: @my_challenge.id, body: Faker::Lorem.sentence)
      end

      it 'has a 200 status code' do
        get :edit, challenge_id: @my_challenge.id, id: @my_comment.id
      end

      context 'current user owns comment' do
        it 'renders the :edit template' do
          get :edit, challenge_id: @my_challenge.id, id: @my_comment.id
          expect(response).to render_template(:edit)
        end
      end

      context 'current user does not own comment' do
        before(:each) do
          sign_out @my_user
          @other_user = User.create(email: Faker::Internet.email, username: Faker::Internet.user_name, password: 'password', password_confirmation: 'password')
          sign_in @other_user
        end

        it 'does not render the :edit template' do
          get :edit, challenge_id: @my_challenge.id, id: @my_comment.id
          expect(response).to_not render_template(:edit)
        end

        it 'redirect to challenge#show' do
          get :edit, challenge_id: @my_challenge.id, id: @my_comment.id
          expect(response).to redirect_to(challenge_path(@my_challenge))
        end
      end
    end

    describe 'PUT #update' do
      before(:each) do
        @my_comment = @my_user.comments.create(challenge_id: @my_challenge.id, body: Faker::Lorem.sentence)
      end

      context 'with valid attributes' do
        it 'saves the edited comment to the database' do
          put :update, challenge_id: @my_challenge.id, id: @my_comment.id, comment: { body: 'Updated' }
          @my_comment.reload
          expect(@my_comment.body).to include('Updated')
        end

        it 'redirects to challenge#show view' do
          put :update, challenge_id: @my_challenge.id, id: @my_comment.id, comment: { body: 'Updated' }
          expect(response).to redirect_to(challenge_path(@my_challenge))
        end
      end

      context 'with invalid attributes' do
        it 'does not save the edited comment to the database' do
          put :update, challenge_id: @my_challenge.id, id: @my_comment.id, comment: { body: nil }
          @my_comment.reload
          expect(@my_comment.body).to_not be(nil)
        end

        it 're-renders the :edit template' do
          put :update, challenge_id: @my_challenge.id, id: @my_comment.id, comment: { body: nil }
          @my_comment.reload
          expect(response).to render_template(:edit)
        end
      end
    end

    describe 'DELETE #destroy' do
      before(:each) do
        @my_comment = @my_user.comments.create(challenge_id: @my_challenge.id, body: Faker::Lorem.sentence)
      end

      context 'current user owns comment' do
        it 'replaces comment body with [deleted]' do
          delete :destroy, id: @my_comment, challenge_id: @my_challenge
          @my_comment.reload
          expect(@my_comment.body).to include('[deleted]')
        end

        it 'redirects to challenge#show view' do
          delete :destroy, id: @my_comment, challenge_id: @my_challenge
          expect(response).to redirect_to(challenge_path(@my_challenge))
        end
      end

      context 'current user does not own comment' do
        before(:each) do
          sign_out @my_user
          @other_user = User.create(email: Faker::Internet.email, username: Faker::Internet.user_name, password: 'password', password_confirmation: 'password')
          sign_in @other_user
        end

        it 'does not replace comment body with [deleted]' do
          delete :destroy, id: @my_comment, challenge_id: @my_challenge
          @my_comment.reload
          expect(@my_comment.body).to_not include('[deleted]')
        end

        it 'redirects to challenge#show view' do
          delete :destroy, id: @my_comment, challenge_id: @my_challenge
          expect(response).to redirect_to(challenge_path(@my_challenge))
        end
      end
    end
  end

  context 'user is logged out' do
  end
end
