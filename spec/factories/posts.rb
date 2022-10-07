FactoryBot.define do
  factory :post do
    association :author
    body { "MyString" }
  end
end
