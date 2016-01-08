require 'rails_helper'
require 'faker'

describe ChallengesController do
  context 'user is logged in' do
    before(:each) do
      @my_user = User.create(email: Faker::Internet.email, password: 'password', password_confirmation: 'password')
      sign_in @my_user
    end

    describe 'GET #easy' do
      it 'has a 200 status code' do
        get :easy
        expect(response.status).to eq(200)
      end

      it 'renders the :easy template' do
        get :easy
        expect(response).to render_template('easy')
      end

      it 'populates an array of easy challenges' do
        easy_challenge = @my_user.challenges.create(name: Faker::App.name, short_description: Faker::Hipster.sentence, long_description: Faker::Hipster.sentence, difficulty: 'easy')
        get :easy
        expect(assigns(:easy)).to eq([easy_challenge])
      end
    end

    describe 'GET #medium' do
      it 'has a 200 status code' do
        get :medium
        expect(response.status).to eq(200)
      end

      it 'renders the :medium template' do
        get :medium
        expect(response).to render_template('medium')
      end

      it 'populates an array of medium challenges' do
        medium_challenge = @my_user.challenges.create(name: Faker::App.name, short_description: Faker::Hipster.sentence, long_description: Faker::Hipster.sentence, difficulty: 'medium')
        get :medium
        expect(assigns(:medium)).to eq([medium_challenge])
      end
    end

    describe 'GET #hard' do
      it 'has a 200 status code' do
        get :hard
        expect(response.status).to eq(200)
      end

      it 'renders the :hard template' do
        get :hard
        expect(response).to render_template('hard')
      end

      it 'populates an array of hard challenges' do
        hard_challenge = @my_user.challenges.create(name: Faker::App.name, short_description: Faker::Hipster.sentence, long_description: Faker::Hipster.sentence, difficulty: 'hard')
        get :hard
        expect(assigns(:hard)).to eq([hard_challenge])
      end
    end

    describe 'GET #index' do
      it 'has a 200 status code' do
        get :index
        expect(response.status).to eq(200)
      end

      it 'renders the :index template' do
        get :index
        expect(response).to render_template('index')
      end

      it 'populates an array of challenges' do
        my_challenge = @my_user.challenges.create(name: Faker::App.name, short_description: Faker::Hipster.sentence, long_description: Faker::Hipster.sentence, difficulty: 'easy')
        get :index
        expect(assigns(:challenges)).to eq([my_challenge])
      end
    end

    describe 'GET #show' do
      before(:each) do
        @my_challenge = @my_user.challenges.create(name: Faker::App.name, short_description: Faker::Hipster.sentence, long_description: Faker::Hipster.sentence, difficulty: 'easy')
      end

      it 'has a 200 status code' do
        get :show, id: @my_challenge.id
        expect(response.status).to eq(200)
      end

      it 'renders the :show template' do
        get :show, id: @my_challenge.id
        expect(response).to render_template('show')
      end
    end

    describe 'GET #new' do
      it 'has a 200 status code' do
        get :new
        expect(response.status).to eq(200)
      end

      it 'renders the :new template' do
        get :new
        expect(response).to render_template('new')
      end
    end

    describe 'POST #create' do
      it 'has a 200 status code' do
        expect(response.status).to eq(200)
      end

      context 'with valid attributes' do
        it 'saves the new challenge to the database' do
          expect {
            post :create, challenge: {
              name: Faker::App.name,
              short_description: Faker::Hipster.sentence,
              long_description: Faker::Hipster.sentence,
              difficulty: 'easy' }
          }.to change(Challenge, :count).by(1)
        end

        it 'redirects to the homepage' do
          post :create, challenge: {
            name: Faker::App.name,
            short_description: Faker::Hipster.sentence,
            long_description: Faker::Hipster.sentence,
            difficulty: 'easy' }
          expect(response).to redirect_to(root_path)
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new challenge to the database' do
          expect {
            post :create, challenge: {
              name: nil,
              short_description: Faker::Hipster.sentence,
              long_description: Faker::Hipster.sentence,
              difficulty: 'easy' }
          }.to_not change(Challenge, :count)
        end

        it 're-renders the :new template' do
          post :create, challenge: {
            name: nil,
            short_description: Faker::Hipster.sentence,
            long_description: Faker::Hipster.sentence,
            difficulty: 'easy' }
          expect(response).to render_template('new')
        end
      end
    end

    describe 'GET #edit' do
      before(:each) do
        @my_challenge = @my_user.challenges.create(name: Faker::App.name, short_description: Faker::Hipster.sentence, long_description: Faker::Hipster.sentence, difficulty: 'easy')
      end

      it 'has a 200 status code' do
        get :edit, id: @my_challenge.id
        expect(response.status).to eq(200)
      end

      context 'current user owns challenge' do
        it 'renders the :edit template' do
          get :edit, id: @my_challenge.id
          expect(response).to render_template('edit')
        end
      end

      context 'current user does not own challenge' do
        before(:each) do
          sign_out @my_user
          @other_user = User.create(email: Faker::Internet.email, password: 'password', password_confirmation: 'password')
          sign_in @other_user
        end

        it 'does not render the :edit template' do
          get :edit, id: @my_challenge.id
          expect(response).to_not render_template('edit')
        end

        it 'redirects to the home page' do
          get :edit, id: @my_challenge.id
          expect(response).to redirect_to(root_path)
        end
      end
    end

    describe 'PUT #update' do
      before(:each) do
        @my_challenge = @my_user.challenges.create(name: Faker::App.name, short_description: Faker::Hipster.sentence, long_description: Faker::Hipster.sentence, difficulty: 'easy')
      end

      it 'has a 200 status code' do
        expect(response.status).to eq(200)
      end

      context 'with valid attributes' do
        it 'saves the edited challenge to the database' do
          put :update, id: @my_challenge.id, challenge: { name: 'Updated' }
          @my_challenge.reload
          expect(@my_challenge.name).to include('Updated')
        end

        it 'redirects to the homepage' do
          put :update, id: @my_challenge.id, challenge: { name: 'Updated' }
          expect(response).to redirect_to(root_path)
        end
      end

      context 'with invalid attributes' do
        it 'does not save the edited challenge to the database' do
          put :update, id: @my_challenge.id, challenge: { name: nil }
          @my_challenge.reload
          expect(@my_challenge.name).to_not be(nil)
        end

        it 're-renders the :edit template' do
          put :update, id: @my_challenge.id, challenge: { name: nil }
          @my_challenge.reload
          expect(response).to render_template('edit')
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'has a 200 status code' do
        expect(response.status).to eq(200)
      end

      context 'current user owns challenge' do
        it 'removes the challenge from the database' do
          @my_challenge = @my_user.challenges.create!(name: Faker::App.name, short_description: Faker::Hipster.sentence, long_description: Faker::Hipster.sentence, difficulty: 'easy')
          expect { delete :destroy, id: @my_challenge.id }.to change(Challenge, :count).by(-1)
        end
      end

      context 'current user does not own challenge' do
        before(:each) do
          @my_challenge = @my_user.challenges.create!(name: Faker::App.name, short_description: Faker::Hipster.sentence, long_description: Faker::Hipster.sentence, difficulty: 'easy')
          sign_out @my_user
          @other_user = User.create(email: Faker::Internet.email, password: 'password', password_confirmation: 'password')
          sign_in @other_user
        end

        it 'does not remove the challenge from the database' do
          expect { delete :destroy, id: @my_challenge.id }.to change(Challenge, :count).by(0)
        end

        it 'redirects to the home page' do
          delete :destroy, id: @my_challenge.id
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end

  context 'user is logged out' do
    describe 'GET #index' do
      it 'has a 200 status code' do
        get :index
        expect(response.status).to eq(200)
      end

      it 'renders the :index template' do
        get :index
        expect(response).to render_template('index')
      end

      it 'populates an array of challenges' do
        my_user = User.create(email: Faker::Internet.email, password: 'password', password_confirmation: 'password')
        my_challenge = my_user.challenges.create(name: Faker::App.name, short_description: Faker::Hipster.sentence, long_description: Faker::Hipster.sentence, difficulty: 'easy')

        get :index
        expect(assigns(:challenges)).to eq([my_challenge])
      end
    end

    describe 'GET #show' do
      before(:each) do
        @my_user = User.create(email: Faker::Internet.email, password: 'password', password_confirmation: 'password')
        @my_challenge = @my_user.challenges.create(name: Faker::App.name, short_description: Faker::Hipster.sentence, long_description: Faker::Hipster.sentence, difficulty: 'easy')
      end

      it 'has a 200 status code' do
        get :show, id: @my_challenge.id
        expect(response.status).to eq(200)
      end

      it 'renders the :show template' do
        get :show, id: @my_challenge.id
        expect(response).to render_template('show')
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
