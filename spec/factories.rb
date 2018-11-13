FactoryBot.define do
  factory :user do
    first_name "test"
    last_name "last_test"
    email "test@email.com"
    password "password"
    factory :manager do
      role 'manager'
    end
  end
end
