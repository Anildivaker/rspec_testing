class ArticleMailer < ApplicationMailer
    default :from => "anildivaker87@gmail.com"
  def welcome_email(article)
    @article = article
    @url  = "http://localhost:3000/articles/"
    mail to: "abc87432156@yopmail.com", subject: "article created successfully "
  end
end
