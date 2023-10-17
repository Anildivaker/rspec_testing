require 'rails_helper'

RSpec.describe Comment, type: :model do
 
  context "Checking the validation" do
    it 'create comment by entering valid data' do
      user = build(:user)
      user.save
      comment = user.comments.create(title:"asdfghjkl", body:"rtyuioasd")
      expect(comment.id).to eq(Comment.last.id)
    end
 
    it 'create comment by entering only body' do
      user = build(:user)
      user.save
      comment = user.comments.create(body:"rtyuioasd")
      expect(comment.id).to eq(Comment.last.id)
    end

    it 'create comment by entering only title' do
      user = build(:user)
      user.save
      comment = user.comments.create(title:"rtyuioasd")
      expect(comment.id).to eq(Comment.last.id)
    end    
    it "has many comments" do
      user = User.reflect_on_association(:comments)
      expect(user.macro).to eq(:has_many)
   end
  end
end
