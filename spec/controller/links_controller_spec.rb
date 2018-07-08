require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  link = Link.find_or_create_by(long_url: 'http://ruby-doc.com/')
  
  describe 'GET #show' do

    it 'Gets 422 if short_url empty' do
      get :show, params: {short_url: ""}
      expect(response.status).to eq(422)
    end

    it 'Gets 404 if short_url not exist' do
      get :show, params: {short_url: "http://not-in-your-db.com/"}
      expect(response.status).to eq(404)
    end

    it 'Redirect to page if find short_url' do
      get :show, params: {short_url: link.short_url}
      expect(response).to redirect_to(link.long_url)
    end

  end

  describe 'POST #create' do

    it 'Gets new url' do
      post :create, params: {longUrl: "https://github.com/"}
      expect(response.status).to eq(200)
      expect(response.body).to eq({url: "#{request.host}/#{Link.last.short_url}"}.to_json)
    end

    it 'Gets old url of existed page' do
      post :create, params: {longUrl: link.long_url}
      expect(response.status).to eq(200)
      expect(response.body).to eq({url: "#{request.host}/#{link.short_url}"}.to_json)
    end

    it 'Gets 422 if long_url empty' do
      post :create, params: {longUrl: ""}
      expect(response.status).to eq(422)
    end

    it 'Gets 422 if params empty' do
      post :create, params: {}
      expect(response.status).to eq(422)
    end

  end
end