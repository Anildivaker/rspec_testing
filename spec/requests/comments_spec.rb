require 'rails_helper'
RSpec.describe "Comments", type: :request do
  describe "GET /index" do
    let(:base_url) {"/comments"}
    let(:create_params) {
      {comment: {title: "title", body: "body"}}
    }
    before(:each) do
      user = create(:user)
      @token = JWT.encode({ user_id:  user.id}, 'secret')
      @comment = Comment.create(title: "title", body: "body",user_id: user.id)
    end
    context "Get all comments" do
      it 'return all comments' do
        get base_url, headers: { 'Authorization' => "bearer "+@token }
        expect(response).to have_http_status(200)
        res = JSON response.body
        expect(res.count).to eq(Comment.count)
      end
    end
    context "Get an comments" do
      it 'Get a single comment' do
        get "#{base_url}/#{@comment.id}", headers: { 'Authorization' => "bearer "+@token }
        expect(response).to have_http_status(200)
        res = JSON response.body
        expect(res["id"]).to eq(@comment.id)
      end
    end
    context "Create comment" do
      it 'return a comments for show comment api' do
        pre_comment_count = Comment.count
        post base_url ,headers: { 'Authorization' => "bearer "+@token } ,params: create_params
        expect(response).to have_http_status(201)
        res = JSON response.body
        expect(Comment.count).to eq(pre_comment_count+1)
      end
      # I did not add validation 
      it 'raise error when pass wrong arguments' do
        post base_url, headers: { 'Authorization' => "bearer "+@token } ,params: {comment: {title: "", body: ""}}
        expect(response).to have_http_status(422)
      end
    end
    context "Update comments" do
      it 'update the title of the comment' do
        patch "#{base_url}/#{@comment.id}", headers: { 'Authorization' => "bearer "+@token } ,params: {comment: {title: "1 title"}}
        expect(response).to have_http_status(200)
        res = JSON response.body
        expect(Comment.find(@comment.id).title).to eq("1 title")
      end
      # I did not add validation 
      it 'raise error when pass wrong arguments' do
        patch "/#{base_url}/#{@comment.id}", headers: { 'Authorization' => "bearer "+@token } ,params: {comment: {title: ""}}
        expect(response).to have_http_status(422)
      end
    end
    context "delete" do
      it 'delete the comment' do
        delete "#{base_url}/#{@comment.id}", headers: { 'Authorization' => "bearer "+@token }
        expect(response).to have_http_status(200)
        expect(Comment.find_by_id(@comment.id)).to eq(nil)
      end
    end
  end
end