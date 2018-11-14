FactoryBot.define do
  factory :lease_user do
    lease nil
    user nil
  end
  factory :lease do
    amount "9.99"
    starts_at "2018-11-13"
    ends_at "2019-11-13"
    payment_date 1
  end
  factory :user do
    first_name "test"
    last_name "last_test"
    email "test@email.com"
    password "password"
    factory :manager do
      role 'manager'
    end
    factory :owner do
      role 'owner'
    end
  end
end
