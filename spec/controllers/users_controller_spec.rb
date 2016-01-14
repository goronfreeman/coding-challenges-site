require 'rails_helper'
require 'faker'

describe UsersController do
  context 'user is logged in' do
    before(:each) do
      @my_user = User.create(email: Faker::Internet.email, username: Faker::Internet.user_name, password: 'password', password_confirmation: 'password')
      sign_in @my_user
    end

    describe 'GET #show' do
      it 'has a 200 status code' do
        get :show, username: @my_user.username
        expect(response.status).to eq(200)
      end

      it 'renders the :show template' do
        get :show, username: @my_user.username
        expect(response).to render_template(:show)
      end
    end

    describe 'GET #comments' do
      it 'has a 200 status code' do
        get :comments, username: @my_user.username
        expect(response.status).to eq(200)
      end

      it 'renders the :comments template' do
        get :comments, username: @my_user.username
        expect(response).to render_template(:comments)
      end
    end

    describe 'GET #submitted' do
      it 'has a 200 status code' do
        get :submitted, username: @my_user.username
        expect(response.status).to eq(200)
      end

      it 'renders the :submitted template' do
        get :submitted, username: @my_user.username
        expect(response).to render_template(:submitted)
      end
    end

    describe 'GET starred' do
      it 'has a 200 status code' do
        get :starred, username: @my_user.username
        expect(response.status).to eq(200)
      end

      it 'renders the :starred template' do
        get :starred, username: @my_user.username
        expect(response).to render_template(:starred)
      end
    end

    describe 'GET completed' do
      it 'has a 200 status code' do
        get :completed, username: @my_user.username
        expect(response.status).to eq(200)
      end

      it 'renders the :completed template' do
        get :completed, username: @my_user.username
        expect(response).to render_template(:completed)
      end
    end
  end
end
