require 'rails_helper'

RSpec.describe ArticlesController, type: :request do
  describe "GET /index" do
    before(:each) do 
      @article = Article.create(title: "This is Article", body: "this is body")
    end

    context "get all the articles" do 
      it "return all the article" do 
        get "/articles" #method and routes
        expect(response).to have_http_status(200)
        res = JSON response.body
        expect(res.count).to eq(Article.count)
      end
    end

    context "Get an articles" do 
      it 'return a articles for show article api' do 
        get "/articles/#{@article.id}"
        expect(response).to have_http_status(200)
        res = JSON response.body
        expect(res["id"]).to eq(@article.id)
      end

      it 'raise error when passing wrong id' do 
        get "/articles/0"
        expect(response).to have_http_status(404)
        res = JSON response.body
        expect(res["message"]).to eq("not found")
      end
    end
  end
end