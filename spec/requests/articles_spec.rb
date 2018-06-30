require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  describe 'GET All Articles' do
    it 'no articles' do
      get '/articles'
      expect(response).to have_http_status(200)
      response_json = JSON.parse(response.body)
      expect(response_json['articlesCount']).to eq 0
      expect(response_json['articles']).to eq []
    end

    it 'one article' do
      Article.create(title: 'New Post', body: 'New body')

      get '/articles'

      expect(response).to have_http_status(200)
      response_json = JSON.parse(response.body)
      expect(response_json['articlesCount']).to eq 1

      article = response_json['articles'].first
      expect(article).to have_key('title')
      expect(article).to have_key('slug')
      expect(article).to have_key('body')
      expect(article).to have_key('createdAt')
      expect(article).to have_key('updatedAt')
      expect(article).to have_key('tagList')
      expect(article).to have_key('author')
      expect(article).to have_key('favorited')
      expect(article['favoritesCount']).to be_an(Integer)
    end
  end

  describe 'GET Articles by Author' do
    before do
      @adam = User.create(email: 'a@example.com', username: 'adam', password: 'password')
      @bob = User.create(email: 'a@example.com', username: 'bob', password: 'password')
      @adam.articles.create(title: 'New Post', body: 'New body')
    end

    it 'adam has 1 article' do
      get '/articles', author: 'adam'

      expect(json['articles'].length).to eq 1
      article = json['articles'].first
      expect(article['title']).to eq 'New Post'
    end

    it 'bob has 0 articles' do
      get '/articles', author: 'bob'
      expect(json['articles']).to eq []
    end
  end

  describe 'GET Articles Favorited by Username' do
    before do
      @adam = User.create(email: 'a@example.com', username: 'adam', password: 'password')
      @bob = User.create(email: 'a@example.com', username: 'bob', password: 'password')
      @post = @adam.articles.create(title: 'New Post', body: 'New body')
    end

    it 'returns empty' do
      get '/articles', favorited: 'bob'
      expect(json['articles']).to eq []
    end

    it "returns bob's favorite" do
      Favorite.create!(user: @bob, article: @post)
      get '/articles', favorited: 'bob'
      expect(json['articles'].length).to eq 1
    end
  end

  describe 'GET Articles by Tag' do
    it 'returns empty' do
      get '/articles', tag: 'dragons'
      expect(json['articles']).to eq []
    end

    it 'returns tag dragon' do
      pending
      get '/articles', tag: 'dragons'
      expect(json['articles'].length).to eq 1
    end
  end

  describe 'GET Single Article by slug' do
    it 'returns the article' do
      Article.create(title: 'How to train your dragons')
      get '/articles/how-to-train-your-dragons'
      article = json['article']
      expect(article).to have_key('title')
      expect(article).to have_key('slug')
      expect(article).to have_key('body')
      expect(article).to have_key('createdAt')
      expect(article).to have_key('updatedAt')
      expect(article).to have_key('tagList')
      expect(article).to have_key('author')
      expect(article).to have_key('favorited')
    end
  end
end
