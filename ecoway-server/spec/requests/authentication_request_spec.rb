require 'rails_helper'

RSpec.describe 'Authentications', type: :request do
  describe 'POST /login' do
    let(:user) { FactoryBot.create(:user, username: 'acushla', password: 'password') }
    let(:login_url) { '/api/v1/login' }
    it 'authenticates the user' do
      post login_url, params: { username: user.username, password: 'password' }

      expect(response).to have_http_status(:created)
      expect(json).to eq({
                           'id' => user.id,
                           'username' => 'acushla',
                           'admin' => false,
                           'token' => AuthenticationTokenService.call(user.id)
                         })
    end

    it 'returns error when username does not exist' do
      post login_url, params: { username: 'ac', password: 'password' }

      expect(response).to have_http_status(:unauthorized)
      expect(json).to eq({
                           'error' => 'No such user'
                         })
    end

    it 'returns error when password is incorrect' do
      post login_url, params: { username: user.username, password: 'incorrect' }

      expect(response).to have_http_status(:unauthorized)
      expect(json).to eq({
                           'error' => 'Хибний пароль'
                         })
    end
  end
end
