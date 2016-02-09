require 'rails_helper'

describe TagsController do
  describe 'GET #index' do
    before do
      get :index
    end

    it 'returns 200' do
      expect(response).to be_success
    end

    it 'renders the :index template' do
      expect(response).to render_template(:index)
    end

    it 'populates an array of tags' do
      tag = create(:tag)

      get :index
      expect(assigns(:tags)).to eq([tag])
    end
  end

  describe 'GET #show' do
    before do
      @tag = create(:tag)
      get :show, name: @tag.name
    end

    it 'returns 200' do
      expect(response).to be_success
    end

    it 'renders the :show template' do
      expect(response).to render_template(:show)
    end
  end
end
