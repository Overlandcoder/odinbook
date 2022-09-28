FactoryBot.define do
  factory :post do
    association :author
    title { "MyString" }
    body { "MyString" }
  end
end
