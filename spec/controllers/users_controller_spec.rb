require 'rails_helper'

describe UsersController do
  context 'user is logged in' do
    let(:user) { create(:user) }

    before { sign_in user }

    describe 'GET #show' do
      before { get :show, username: user.username }

      it 'returns 200' do
        expect(response).to be_success
      end

      it 'renders the :show template' do
        expect(response).to render_template(:show)
      end
    end

    describe 'GET #comments' do
      before { get :comments, username: user.username }

      it 'returns 200' do
        expect(response).to be_success
      end

      it 'renders the :comments template' do
        expect(response).to render_template(:comments)
      end
    end

    describe 'GET #submitted' do
      before { get :submitted, username: user.username }

      it 'returns 200' do
        expect(response).to be_success
      end

      it 'renders the :submitted template' do
        expect(response).to render_template(:submitted)
      end
    end

    describe 'GET #starred' do
      before { get :starred, username: user.username }

      it 'returns 200' do
        expect(response).to be_success
      end

      it 'renders the :starred template' do
        expect(response).to render_template(:starred)
      end
    end

    describe 'GET #completed' do
      before { get :completed, username: user.username }

      it 'returns 200' do
        expect(response).to be_success
      end

      it 'renders the :completed template' do
        expect(response).to render_template(:completed)
      end
    end
  end
end
