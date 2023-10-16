require 'rails_helper'
require 'jwt'

RSpec.describe "Users", type: :request do
  let(:valid_user_params) do |example|
    {
      username: 'tes1tuser',
      password: 'Pas@123sword',
      name: 'John',
      surname: 'Doe',
      email: 'john.doe@example.com',
      number: '1234567890'
    }
  end

  describe '#create' do
  it 'creates a user and returns a valid token' do
    post "/users", params: { user: valid_user_params }

    expect(response).to have_http_status(:ok)
    expect(response.content_type).to eq('application/json; charset=utf-8')

    body = JSON.parse(response.body)
    token = body['token']

    decoded_token = JWT.decode(token, 'your_secret_key', true, algorithm: 'HS256')
    user_id = decoded_token[0]['user_id']
    expect(user_id).to eq(User.last.id)
  end
  end

  describe '#login' do
    let!(:user) { User.create(valid_user_params) }

    it 'logs in a user and returns a valid token' do
      post :login, params: { user: { username: valid_user_params[:username], password: valid_user_params[:password] } }

      expect(response).to have_http_status(:ok)
      expect(response).to have_content_type(:json)

      body = JSON.parse(response.body)
      token = body['token']

      decoded_token = JWT.decode(token, 'your_secret_key', true, algorithm: 'HS256')
      user_id = decoded_token[0]['user_id']
      expect(user_id).to eq(user.id)
    end
  end
end
