FactoryBot.define do
  factory :invited_user do
    lease nil
    role "MyString"
    email "MyString"
  end
  
  factory :lease_user do
    lease nil
    user nil
  end
  
  factory :lease do
    amount '2000'
    starts_at "2018-11-13"
    ends_at "2019-11-13"
    payment_day 1
    association :owner, factory: :owner
  end
  
  factory :user do
    first_name Faker::Name.unique.first_name
    last_name Faker::Name.unique.first_name
    email Faker::Internet.unique.email
    password "password"
    factory :manager do
      first_name Faker::Name.unique.first_name
      last_name Faker::Name.unique.first_name
      email Faker::Internet.unique.email
      password "password"
      role 'manager'
    end
    factory :owner do
      first_name Faker::Name.unique.first_name
      last_name Faker::Name.unique.first_name
      email Faker::Internet.unique.email
      password "password"
      role 'owner'
    end
  end
end
