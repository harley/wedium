require 'rails_helper'

RSpec.describe 'Auth', type: :request do
  describe 'POST /users' do
    let(:new_user_params) do
      {
        user: {
          username: 'username',
          email: 'new@example.com',
          password: 'password'
        }
      }
    end

    it 'Register' do
      post '/users', new_user_params
      expect(response).to have_http_status(200)

      user = JSON.parse(response.body)['user']
      expect(user['email']).to eq 'new@example.com'
      expect(user['username']).to eq 'username'
      expect(user).to have_key('bio')
      expect(user).to have_key('image')
      expect(user).to have_key('token')
    end
  end

  context 'With an existing User' do
    let(:user) do
      User.create!(
        email: 'a@example.comm',
        password: 'password',
        username: 'username'
      )
    end

    describe 'GET /user' do
      let(:token) { User.generate_jwt(user.id) }
      let(:valid_headers) { { 'Authorization' => "Token #{token}" } }

      it 'Current User' do
        get '/user', {}, valid_headers
        expect(response).to have_http_status(200)
        response_user = JSON.parse(response.body)['user']
        expect(response_user).to have_key('email')
      end
    end

    describe 'PUT /user' do
      let(:token) { User.generate_jwt(user.id) }
      let(:valid_headers) { { 'Authorization' => "Token #{token}" } }
      let(:new_params) do
        { user: { bio: 'New bio', image: 'New image' } }
      end

      it 'Update User' do
        put '/user', new_params, valid_headers
        response_user = JSON.parse(response.body)['user']
        expect(response_user['bio']).to eq 'New bio'
        expect(response_user['image']).to eq 'New image'
      end
    end

    describe 'POST /users/login' do
      let(:valid_login_params) do
        {
          user: {
            email: user.email,
            password: user.password
          }
        }
      end
      it 'Login' do
        post '/users/login', valid_login_params
        expect(response).to have_http_status(200)
        response_user = JSON.parse(response.body)['user']
        expect(response_user).to have_key('email')
      end
    end

    describe 'POST /users/login' do
      let(:valid_login_params) do
        {
          user: {
            email: user.email,
            password: user.password
          }
        }
      end

      it 'Login and Remember Token' do
        post '/users/login', valid_login_params
        expect(response).to have_http_status(200)

        response_user = JSON.parse(response.body)['user']
        token = response_user['token']
        valid_headers = { 'Authorization' => "Token #{token}" }

        get '/user', {}, valid_headers
        expect(response).to have_http_status(200)

        response_user = JSON.parse(response.body)['user']
        expect(response_user['email']).to eq user.email
      end
    end
  end
end
