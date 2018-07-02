require 'rails_helper'

RSpec.describe 'ArticlesWithAuths', type: :request do
  describe 'POST Create Article' do
    before do
      @adam = User.create(username: 'adam', email: 'a@example.com', password: 'password')
      @token = @adam.token
      @valid_headers = {
        'Authorization' => "Token #{@token}"
      }
      @article_params = {
        'article': {
          'title': 'How to train your dragon',
          'description': 'Ever wonder how?',
          'body': 'Very carefully.',
          'tagList': ['dragons','training']
        }
      }
    end

    it 'creates an article' do
      post '/articles', @article_params, @valid_headers
      expect(response).to have_http_status(200)
      article = json['article']
      expect(article['title']).to eq 'How to train your dragon'
      expect(article).to have_key('slug')
      expect(article).to have_key('body')
      expect(article).to have_key('createdAt')
      expect(article).to have_key('updatedAt')
      expect(article).to have_key('description')
      expect(article['tagList']).to be_an(Array)
      expect(article).to have_key('author')
      expect(article).to have_key('favorited')
      expect(article).to have_key('favoritesCount')
      expect(article['favoritesCount']).to be_an(Integer)
    end
  end

  describe 'DEL Delete Article' do
    before do
      @adam = User.create(username: 'adam', email: 'a@example.com', password: 'password')
      @token = @adam.token
      @valid_headers = {
        'Authorization' => "Token #{@token}"
      }
    end

    it 'deletes how-to-train-your-dragon article' do
      Article.create!(
        user: @adam,
        title: 'How to train your dragon',
        description: 'Ever wonder how?',
        body: 'Very carefully.'
      )
      delete '/articles/how-to-train-your-dragon', {}, @valid_headers
      expect(response).to have_http_status(200)
      expect(Article.count).to eq 0
    end
  end
end
