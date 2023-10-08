FactoryBot.define do
  # factory :user do
  #   surname { "MyString" }
  #   name { "MyString" }
  #   email { "MyString" }
  #   number { 1 }
  #   username { "MyString" }
  #   password { "MyString" }



  # t.string "surname"
  # t.string "name"
  # t.string "email"
  # t.integer "number"
  # t.string "username"
  # t.string "password_digest"
    factory :user, class: "User" do
      name { FFaker::Name.unique.name }
      surname { FFaker::Name.unique.name }
      username { FFaker::Name.unique.name }
      email { FFaker::Internet.unique.email }
      number { FFaker::Number.number(digits: 10) } 
    end
end

