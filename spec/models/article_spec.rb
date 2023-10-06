require 'rails_helper'

RSpec.describe Article, type: :model do
  context "Checking the validation" do
    it 'create article by entering valid data' do
      # here we use ffaker and factory where (:article) is the name of the factory
      article = create(:article)
      article.save
      # article = Article.create(title:"abc", body:"xyz")
      expect(article.id).to eq(Article.last.id)
    end

    it 'validate if title is blank' do
      # when we have to over-write the factory bot then we use just paas that field
      article =  build(:article, title:"")
      article.save
      expect(article.id).to eq(nil)
      expect(article.errors[:title]).to eq(["can't be blank"])
    end

    it 'validate if body is blank' do
      article =  build(:article, body:"")
      article.save
      expect(article.id).to eq(nil)
      expect(article.errors[:body]).to eq(["can't be blank"])
    end

    it 'validate if body & title are blank' do
      # when we have to over-write the factory bot then we use just paas that field
      article =  build(:article, title:"", body:"")
      article.save
      expect(article.id).to eq(nil)
      expect(article.errors[:title]).to eq(["can't be blank"])
    end
  end
end
