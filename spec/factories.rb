FactoryBot.define do
  factory :post do
    title "MyText"
    body "MyText"
  end
  factory :user do
    name "test"
    email "test@email.com"
    password "password"
  end
end
