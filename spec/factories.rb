FactoryBot.define do
  factory :acceptance do
    accepted false
  end
  factory :invited_user do
    lease
    role 'tenant'
    email Faker::Internet.unique.email
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
    address_line_1 "123 Main st"
    address_line_2 "unit 345"
    city "Seattle"
    zip "98122"
    state "WA"
    association :owner, factory: :owner
  end

  factory :user do
    first_name Faker::Name.unique.first_name
    last_name Faker::Name.unique.first_name
    sequence :email do
      Faker::Internet.unique.email
    end
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
