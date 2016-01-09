require 'rails_helper'
require 'faker'

describe TagsController do
  describe 'GET #index' do
    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'renders the :index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'populates an array of tags' do
      my_tag = Tag.create(name: 'CSS')
      get :index
      expect(assigns(:tags)).to eq([my_tag])
    end
  end

  describe 'GET #show' do
    before(:each) do
      @my_tag = Tag.create(name: 'CSS')
    end

    it 'has a 200 status code' do
      get :show, id: @my_tag.id
      expect(response.status).to eq(200)
    end

    it 'renders the :show template' do
      get :show, id: @my_tag.id
      expect(response).to render_template('show')
    end
  end
end
