# spec/controllers/users_controller_spec.rb
require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe '#create and login' do
    let(:base_url) {"/users"}
    let(:create_params) {
      {user: {name: "anil", surname: "div",email: "an12@gmail.com",number:1234567892,username: "anil12345678",password:"Anil@123"}}
    }
    before(:each) do
      user = create(:user)
      @token = JWT.encode({ user_id:  user.id}, 'secret')
      @user = User.create(name: "ravi12", surname: "ravii",username: "ravi123456",password:"Anil@123",email: "ravi123@gmail.com",number:1239567892)
    end
    context "Create User" do
      it 'return a user for show user api' do
        pre_user_count = User.count
        post base_url, params: create_params
        expect(response).to have_http_status(200)
        res = JSON response.body
        expect(User.count).to eq(pre_user_count+1)
      end
      it 'raise error when pass wrong arguments' do
        post base_url, params: {user: {name: "", surname: "", email: "", number:nil,username: "",password:" "}}
        expect(response).to have_http_status(422)
      end
    end
  
    context 'Login' do
      it 'returns a valid user and token' do
        post  "/login", params: { user: { username: @user.username, password: "Anil@123" } }
        expect(response).to have_http_status(:ok)
      end
      it 'returns invalid user error' do
        post  "/login", params: { user: { username: @user.username, password: "aa1233@" } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
    