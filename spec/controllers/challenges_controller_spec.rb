require 'rails_helper'
require 'faker'

describe ChallengesController do
  context 'user is logged in' do
    before(:each) do
      @user = User.create(email: Faker::Internet.email, password: 'password', password_confirmation: 'password')
      sign_in @user
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
        my_challenge = @user.challenges.create(name: Faker::App.name, short_description: Faker::Hipster.sentence, long_description: Faker::Hipster.sentence)
        get :index
        expect(assigns(:challenges)).to eq([my_challenge])
      end
    end

    describe 'GET #show' do
      before(:each) do
        @my_challenge = @user.challenges.create(name: Faker::App.name, short_description: Faker::Hipster.sentence, long_description: Faker::Hipster.sentence)
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
              long_description: Faker::Hipster.sentence }
          }.to change(Challenge, :count).by(1)
        end

        it 'redirects to the homepage' do
          post :create, challenge: {
            name: Faker::App.name,
            short_description: Faker::Hipster.sentence,
            long_description: Faker::Hipster.sentence }
          expect(response).to redirect_to(root_path)
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new challenge to the database' do
          expect {
            post :create, challenge: {
              name: nil,
              short_description: Faker::Hipster.sentence,
              long_description: Faker::Hipster.sentence }
          }.to_not change(Challenge, :count)
        end

        it 're-renders the :new template' do
          post :create, challenge: {
            name: nil,
            short_description: Faker::Hipster.sentence,
            long_description: Faker::Hipster.sentence }
          expect(response).to render_template(:new)
        end
      end
    end

    describe 'GET #edit' do
      before(:each) do
        @my_challenge = @user.challenges.create(name: Faker::App.name, short_description: Faker::Hipster.sentence, long_description: Faker::Hipster.sentence)
      end

      it 'has a 200 status code' do
        get :edit, id: @my_challenge.id
        expect(response.status).to eq(200)
      end

      it 'renders the :edit template' do
        get :edit, id: @my_challenge.id
        expect(response).to render_template(:edit)
      end
    end

    describe 'PUT #update' do
      before(:each) do
        @my_challenge = @user.challenges.create(name: Faker::App.name, short_description: Faker::Hipster.sentence, long_description: Faker::Hipster.sentence)
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
          expect(response).to render_template(:edit)
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'has a 200 status code' do
        expect(response.status).to eq(200)
      end

      it 'removes the challenge from the database' do
        @my_challenge = @user.challenges.create!(name: Faker::App.name, short_description: Faker::Hipster.sentence, long_description: Faker::Hipster.sentence)
        expect { delete :destroy, id: @my_challenge.id }.to change(Challenge, :count).by(-1)
      end
    end
  end
end

# TODO
# test when user logged in and logged out
