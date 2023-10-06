FactoryBot.define do 
    factory :article, class: "Article" do
        title { FFaker::Name.unique.name }
        body { FFaker::Name.unique.name }
    end
end