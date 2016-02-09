require 'rails_helper'

describe ChallengesController do
  context 'user is logged in' do
    before do
      @user = create(:user)
      sign_in @user
    end

    describe 'GET #easy' do
      it 'returns 200' do
        get :easy
        expect(response).to be_success
      end

      it 'renders the :easy template' do
        get :easy
        expect(response).to render_template(:easy)
      end

      it 'populates an array of easy challenges' do
        easy_challenge = create(:challenge, :with_tag)

        get :easy
        expect(assigns(:easy)).to eq([easy_challenge])
      end
    end

    describe 'GET #medium' do
      it 'returns 200' do
        get :medium
        expect(response).to be_success
      end

      it 'renders the :medium template' do
        get :medium
        expect(response).to render_template(:medium)
      end

      it 'populates an array of medium challenges' do
        medium_challenge = create(:challenge, :with_tag, difficulty: 'medium')

        get :medium
        expect(assigns(:medium)).to eq([medium_challenge])
      end
    end

    describe 'GET #hard' do
      it 'returns 200' do
        get :hard
        expect(response).to be_success
      end

      it 'renders the :hard template' do
        get :hard
        expect(response).to render_template(:hard)
      end

      it 'populates an array of hard challenges' do
        hard_challenge = create(:challenge, :with_tag, difficulty: 'hard')

        get :hard
        expect(assigns(:hard)).to eq([hard_challenge])
      end
    end

    describe 'GET #index' do
      it 'returns 200' do
        get :index
        expect(response).to be_success
      end

      it 'renders the :index template' do
        get :index
        expect(response).to render_template(:index)
      end

      it 'populates an array of challenges' do
        challenge = create(:challenge, :with_tag)

        get :index
        expect(assigns(:challenges)).to eq([challenge])
      end
    end

    describe 'GET #show' do
      before do
        @challenge = create(:challenge, :with_tag)
      end

      it 'returns 200' do
        get :show, id: @challenge.id
        expect(response).to be_success
      end

      it 'renders the :show template' do
        get :show, id: @challenge.id
        expect(response).to render_template(:show)
      end
    end

    describe 'GET #new' do
      it 'returns 200' do
        get :new
        expect(response).to be_success
      end

      it 'renders the :new template' do
        get :new
        expect(response).to render_template(:new)
      end
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        it 'saves the new challenge to the database' do
          # FIXME
          # expect { post :create, challenge: attributes_for(:challenge_with_tag) }.to change(Challenge, :count).by(1)
          puts attributes_for(:challenge_with_tag)
        end

        it 'redirects to the homepage' do
          # FIXME
          post :create, challenge: attributes_for(:challenge, :with_tag, user_id: @user.id)
          expect(response).to redirect_to(root_path)
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new challenge to the database' do
          # FIXME
          expect { post :create, challenge: attributes_for(:challenge, :with_tag, name: nil) }.to_not change(Challenge, :count)
        end

        it 're-renders the :new template' do
          # FIXME
          post :create, challenge: attributes_for(:challenge, :with_tag, name: nil)
          expect(response).to render_template(:new)
        end
      end
    end

    describe 'GET #edit' do
      before do
        @challenge = create(:challenge, :with_tag, user_id: @user.id)
      end

      it 'returns 200' do
        get :edit, id: @challenge.id
        expect(response).to be_success
      end

      context 'current user owns challenge' do
        it 'renders the :edit template' do
          get :edit, id: @challenge.id
          expect(response).to render_template(:edit)
        end
      end

      context 'current user does not own challenge' do
        before do
          sign_out @user
          @another_user = create(:user)
          sign_in @another_user
        end

        it 'does not render the :edit template' do
          get :edit, id: @challenge.id
          expect(response).to_not render_template(:edit)
        end

        it 'redirects to the home page' do
          get :edit, id: @challenge.id
          expect(response).to redirect_to(root_path)
        end
      end
    end

    describe 'PUT #update' do
      before do
        @challenge = create(:challenge, :with_tag, user_id: @user.id)
      end

      context 'with valid attributes' do
        before do
          put :update, id: @challenge.id, challenge: { name: 'Updated' }
        end

        it 'saves the edited challenge to the database' do
          @challenge.reload
          expect(@challenge.name).to include('Updated')
        end

        it 'redirects to the homepage' do
          expect(response).to redirect_to(root_path)
        end
      end

      context 'with invalid attributes' do
        before do
          put :update, id: @challenge.id, challenge: { name: nil }
        end

        it 'does not save the edited challenge to the database' do
          @challenge.reload
          expect(@challenge.name).to_not be(nil)
        end

        it 're-renders the :edit template' do
          @challenge.reload
          expect(response).to render_template(:edit)
        end
      end
    end

    describe 'DELETE #destroy' do
      context 'current user owns challenge' do
        before do
          @challenge = create(:challenge, :with_tag, user_id: @user.id)
        end

        it 'removes the challenge from the database' do
          expect { delete :destroy, id: @challenge.id }.to change(Challenge, :count).by(-1)
        end

        it 'redirects to the home page' do
          delete :destroy, id: @challenge.id
          expect(response).to redirect_to(root_path)
        end
      end

      context 'current user does not own challenge' do
        before do
          @challenge = create(:challenge, :with_tag, user_id: @user.id)
          sign_out @user
          @another_user = create(:user)
          sign_in @another_user
        end

        it 'does not remove the challenge from the database' do
          expect { delete :destroy, id: @challenge.id }.to change(Challenge, :count).by(0)
        end

        it 'redirects to the home page' do
          delete :destroy, id: @challenge.id
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end

  context 'user is logged out' do
    describe 'GET #easy' do
      it 'returns 200' do
        get :easy
        expect(response).to be_success
      end

      it 'renders the :easy template' do
        get :easy
        expect(response).to render_template(:easy)
      end

      it 'populates an array of easy challenges' do
        easy_challenge = create(:challenge, :with_tag)

        get :easy
        expect(assigns(:easy)).to eq([easy_challenge])
      end
    end

    describe 'GET #medium' do
      it 'returns 200' do
        get :medium
        expect(response).to be_success
      end

      it 'renders the :medium template' do
        get :medium
        expect(response).to render_template(:medium)
      end

      it 'populates an array of medium challenges' do
        medium_challenge = create(:challenge, :with_tag, difficulty: 'medium')

        get :medium
        expect(assigns(:medium)).to eq([medium_challenge])
      end
    end

    describe 'GET #hard' do
      it 'returns 200' do
        get :hard
        expect(response).to be_success
      end

      it 'renders the :hard template' do
        get :hard
        expect(response).to render_template(:hard)
      end

      it 'populates an array of hard challenges' do
        hard_challenge = create(:challenge, :with_tag, difficulty: 'hard')

        get :hard
        expect(assigns(:hard)).to eq([hard_challenge])
      end
    end

    describe 'GET #index' do
      it 'returns 200' do
        get :index
        expect(response).to be_success
      end

      it 'renders the :index template' do
        get :index
        expect(response).to render_template(:index)
      end

      it 'populates an array of challenges' do
        challenge = create(:challenge, :with_tag)

        get :index
        expect(assigns(:challenges)).to eq([challenge])
      end
    end

    describe 'GET #show' do
      before(:each) do
        @challenge = create(:challenge, :with_tag)
      end

      it 'returns 200' do
        get :show, id: @challenge.id
        expect(response).to be_success
      end

      it 'renders the :show template' do
        get :show, id: @challenge.id
        expect(response).to render_template(:show)
      end
    end

    describe 'GET #new' do
      it 'redirects to the sign in page' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'POST #create' do
      it 'redirects to the sign in page' do
        post :create
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
