require 'rails_helper'

describe TagsController do
  let(:tag) { create(:tag) }

  describe 'GET #index' do
    before { get :index }

    it 'returns 200' do
      expect(response).to be_success
    end

    it 'renders the :index template' do
      expect(response).to render_template(:index)
    end

    it 'populates an array of tags' do
      get :index
      expect(assigns(:tags)).to eq([tag])
    end
  end

  describe 'GET #show' do
    before { get :show, name: tag.name }

    it 'returns 200' do
      expect(response).to be_success
    end

    it 'renders the :show template' do
      expect(response).to render_template(:show)
    end
  end
end
