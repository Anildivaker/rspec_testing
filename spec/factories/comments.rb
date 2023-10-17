FactoryBot.define do
  factory :comment do
    title { FFaker::Name.unique.name }
    body { FFaker::Name.unique.name }
  end
end
