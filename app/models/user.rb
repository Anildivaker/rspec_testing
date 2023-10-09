class User < ApplicationRecord
    has_secure_password
    validates :name, presence: true, length: { minimum: 2 }
    validates :surname, presence: true, length: { maximum: 30 }
    validates :username, presence: true, length: { maximum: 30 }, uniqueness: true
    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, presence: true, uniqueness: true
    validates :number, presence: true, uniqueness: true, numericality: true, length: { :minimum => 10, :maximum => 15 }

    PASSWORD_FORMAT = /\A
        (?=.{8,})          # Must contain 8 or more characters
        (?=.*\d)           # Must contain a digit
        (?=.*[a-z])        # Must contain a lower case character
        (?=.*[A-Z])        # Must contain an upper case character
        (?=.*[[:^alnum:]]) # Must contain a symbol
    /x

    validates :password, 
    format: { with: PASSWORD_FORMAT }
end
