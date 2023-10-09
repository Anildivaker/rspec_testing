FactoryBot.define do
  factory :user, class: "User" do
    name { FFaker::Name.unique.name }
    surname { FFaker::Name.unique.name }
    username { (FFaker::Company.suffix + rand(123452..987654).to_s).delete(' ') }
    email { FFaker::Internet.unique.email }
    number { rand(6123456789..9876543210) } 
    password { FFaker::Internet.password(4, 5)+ ['@', '#', '$', '%', '&'].join('') + rand(9).to_s + ('a'..'z').to_a[rand(26)] + ('A'..'z').to_a[rand(26)]}
  end
end

