require 'rails_helper'

describe CommentsController do
  context 'user is logged in' do
    let(:user) { create(:user) }
    let(:challenge) { create(:challenge, :with_tag) }
    let(:comment) { create(:comment, user_id: user.id, challenge_id: challenge.id) }

    before { sign_in user }

    describe 'POST #create' do
      context 'with valid attributes' do
        it 'saves the new comment to the database' do
          expect {
            post :create, challenge_id: challenge.id, comment: attributes_for(:comment)
          }.to change(Comment, :count).by(1)
        end

        it 'redirects to challenge' do
          post :create, challenge_id: challenge.id, comment: attributes_for(:comment)
          expect(response).to redirect_to(challenge_path(challenge))
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new comment to the database' do
          expect {
            post :create, challenge_id: challenge.id, comment: attributes_for(:comment, body: nil)
          }.to_not change(Comment, :count)
        end
      end
    end

    describe 'GET #edit' do
      it 'returns 200' do
        get :edit, challenge_id: challenge.id, id: comment.id
        expect(response).to be_success
      end

      context 'current user owns comment' do
        it 'renders the :edit template' do
          get :edit, challenge_id: challenge.id, id: comment.id
          expect(response).to render_template(:edit)
        end
      end

      context 'current user does not own comment' do
        let(:another_user) { create(:user) }

        before do
          sign_out user
          sign_in another_user
        end

        it 'does not render the :edit template' do
          get :edit, challenge_id: challenge.id, id: comment.id
          expect(response).to_not render_template(:edit)
        end

        it 'redirect to challenge#show' do
          get :edit, challenge_id: challenge.id, id: comment.id
          expect(response).to redirect_to(challenge_path(challenge))
        end
      end
    end

    describe 'PUT #update' do
      context 'with valid attributes' do
        before do
          put :update, challenge_id: challenge.id, id: comment.id, comment: attributes_for(:comment, body: 'Updated')
        end

        it 'saves the edited comment to the database' do
          comment.reload
          expect(comment.body).to include('Updated')
        end

        it 'redirects to challenge#show' do
          expect(response).to redirect_to(challenge_path(challenge))
        end
      end

      context 'with invalid attributes' do
        before do
          put :update, challenge_id: challenge.id, id: comment.id, comment: attributes_for(:comment, body: nil)
        end

        it 'does not save the edited comment to the database' do
          comment.reload
          expect(comment.body).to_not be_nil
        end

        it 're-renders the :edit template' do
          comment.reload
          expect(response).to render_template(:edit)
        end
      end
    end

    describe 'DELETE #destroy' do
      context 'current user owns comment' do
        before { delete :destroy, id: comment, challenge_id: challenge }

        it 'replaces comment body with [deleted]' do
          comment.reload
          expect(comment.body).to include('[deleted]')
        end

        it 'redirects to challenge#show view' do
          expect(response).to redirect_to(challenge_path(challenge))
        end
      end

      context 'current user does not own comment' do
        let(:another_user) { create(:user) }

        before do
          sign_out user
          sign_in another_user
          delete :destroy, id: comment, challenge_id: challenge
        end

        it 'does not replace comment body with [deleted]' do
          comment.reload
          expect(comment.body).to_not include('[deleted]')
        end

        it 'redirects to challenge#show' do
          expect(response).to redirect_to(challenge_path(challenge))
        end
      end
    end
  end

  context 'user is logged out' do
    # TODO: add looged out context
  end
end
