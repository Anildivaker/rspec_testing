require 'rails_helper'
# t.integer "number"
# t.string "password"

RSpec.describe User, type: :model do
  context "Checkin the validation" do
    
    # save user by enter valid data 
    it " save user by enter valid data " do
      user = build(:user)
      t = user.save
      expect(t).to eq(true)
    end
    
    # Name
    it " Validate user if name is not present " do 
      user = build(:user, name:"")
      user.save
      expect(user.id).to eq(nil)
      expect(user.errors[:name]).to eq(["can't be blank", "is too short (minimum is 2 characters)"])
    end

    it " Validate user if name is too short(less than 2 char.) " do 
      user = build(:user, name:"a")
      user.save
      expect(user.errors[:name]).to eq(["is too short (minimum is 2 characters)"])
    end

    # Surname
    it " Validate user if surname is blank " do 
      user = build(:user, surname:"")
      user.save
      expect(user.id).to eq(nil)
      expect(user.errors[:surname]).to eq(["can't be blank"])
    end

    it " Validate user if Username is too long(more than 30 char.) " do 
      user = build(:user, surname:"asdfghjklasdfghjklsdfghjkloiuytrewqasdf")
      user.save
      expect(user.errors[:surname]).to eq(["is too long (maximum is 30 characters)"])
    end

    # Username
    it " Validate user if username is blank " do 
      # debugger
      user = build(:user, username:"")
      user.save
      expect(user.id).to eq(nil)
      expect(user.errors[:username]).to eq(["can't be blank", "is invalid"])
    end

    it " Validate that Username should be unique " do
      user = build(:user, username:"anil")
      user.save
      user = build(:user, username:"anil")
      user.save
      expect(user.errors[:username]).to eq(["has already been taken"])
    end

    it " Validate user if Username is too long(more than 30 char.) " do 
      user = build(:user, username:"asdfghjklasdfghjklsdfghjkloiuytrewqasdf")
      user.save
      expect(user.errors[:username]).to eq(["is too long (maximum is 30 characters)"])
    end

    # email
    it " Validate user if email is blank " do 
      user = build(:user, email:"",)
      user.save
      expect(user.id).to eq(nil)
      expect(user.errors[:email]).to eq(["is invalid", "can't be blank"])
    end

    it " Validate user if email is invalid " do 
      user = build(:user, email:"usergmail.com",)
      user.save
      expect(user.errors[:email]).to eq(["is invalid"])
    end

    it " Validate that email should be unique " do
      user = build(:user, email:"anil@gmail.com")
      user.save
      user = build(:user, email:"anil@gmail.com")
      user.save
      expect(user.errors[:email]).to eq(["has already been taken"])
    end

    # number
    it " Validate user if Mobile number is blank " do 
      user = build(:user, number:"",)
      user.save
      expect(user.id).to eq(nil)
      expect(user.errors[:number]).to eq(["can't be blank", "is not a number", "is too short (minimum is 10 characters)"])
    end

    it " Validate user if number is short (less than 10 num) " do 
      user = build(:user, number:12345678,)
      user.save
      expect(user.errors[:number]).to eq(["is too short (minimum is 10 characters)"])
    end

    it " Validate user if number is long(more than 15 num) " do 
      user = build(:user, number:12345678122345345,)
      user.save
      expect(user.errors[:number]).to eq(["is too long (maximum is 15 characters)"])
    end

    it " Validate that number should be unique " do
      user1 = build(:user, number:1234567890)
      user1.save
      user = build(:user, number:1234567890)
      user.save
      expect(user.errors[:number]).to eq(["has already been taken"])
    end
    
    it " Validate user if number is alphanumeric & specail char. " do 
      user = build(:user, number:"User123$456782323")
      user.save
      expect(user.errors[:number]).to eq(["is not a number", "is too short (minimum is 10 characters)"])
    end

  end
end




