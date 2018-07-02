require 'rails_helper'

RSpec.describe 'ArticlesWithAuths', type: :request do
  let(:user) { User.create!(username: 'adam', email: 'a@example.com', password: 'password') }
  let(:auth_token) { user.token }
  let(:valid_user_headers) { { 'Authorization' => "Token #{auth_token}" } }

  describe 'POST Create Article' do
    it 'creates an article' do
      article_params = {
        'article': {
          'title': 'How to train your dragon',
          'description': 'Ever wonder how?',
          'body': 'Very carefully.',
          'tagList': ['dragons','training']
        }
      }
      post '/articles', article_params, valid_user_headers
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
    it 'deletes how-to-train-your-dragon article' do
      Article.create!(
        user: user,
        title: 'How to train your dragon',
        description: 'Ever wonder how?',
        body: 'Very carefully.'
      )
      delete '/articles/how-to-train-your-dragon', {}, valid_user_headers
      expect(response).to have_http_status(200)
      expect(Article.count).to eq 0
    end
  end

  describe 'PUT Update Article' do
    it 'updates how-to-train-your-dragon article' do
      Article.create!(
        user: user,
        title: 'How to train your dragon',
        description: 'Ever wonder how?',
        body: 'Very carefully.'
      )
      updated_content = { article: { body: 'With two hands!!' } }
      put '/articles/how-to-train-your-dragon', updated_content, valid_user_headers
      expect(response).to have_http_status(200)
      expect(json['article']['body']).to eq 'With two hands!!'
    end
  end

  describe 'POST Favorite Article' do
    it 'favorites how-to-train-your-dragon article' do
      article = Article.create!(
        user: user,
        title: 'How to train your dragon',
        description: 'Ever wonder how?',
        body: 'Very carefully.'
      )
      post '/articles/how-to-train-your-dragon/favorite', {}, valid_user_headers
      expect(json['article']['favorited']).to eq true
    end
  end

  describe 'DEL Unfavorite Article' do
    it 'unfavorites how-to-train-your-dragon article' do
      article = Article.create!(
        user: user,
        title: 'How to train your dragon',
        description: 'Ever wonder how?',
        body: 'Very carefully.'
      )
      article.favorite_by!(user)
      delete '/articles/how-to-train-your-dragon/favorite', {}, valid_user_headers
      expect(json['article']['favorited']).to eq false
    end
  end
end
