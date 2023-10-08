class User < ApplicationRecord
    # has_secure_password
    validates :name, presence: true, length: { minimum: 2 }
    validates :surname, presence: true, length: { maximum: 30 }
    validates :username, presence: true, length: { maximum: 30 }, uniqueness: true
    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, presence: true, uniqueness: true
    validates :number, presence: true, uniqueness: true, numericality: true, length: { :minimum => 10, :maximum => 15 }
    # PASSWORD_REQUIREMENT = /\A
    #     (?=.{8,}) #minimum 8 char. long
    #     (?=.*\d) #contain at least one num
    #     (?=.*[a-z]) #minimum 1 lowercase letter
    #     (?=.*[A-Z]) #minimum 1 uppercase letter
    #     (?=.*[[:^alnm:]]) #at least one symbol
    # /x
    # validates :password, format: PASSWORD_REQUIREMENT

end
