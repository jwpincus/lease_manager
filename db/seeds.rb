# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

owner = User.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: "owner@email.com",
  password: 'password',
  password_confirmation: 'password',
  role: 'owner'
)
lease = owner.leases.create(
  amount: '2500',
  starts_at: Date.today + 1.week,
  ends_at: Date.today + 1.week + 1.year,
  payment_day: 1,
  address_line_1: 'Unit 303',
  address_line_2: '1133 18th Ave',
  city: 'Denver',
  state: 'CO',
  zip: '80218'
)
lease2 = owner.leases.create(
  amount: '2000',
  starts_at: Date.today + 6.months,
  ends_at: Date.today + 2.year,
  payment_day: 1,
  address_line_1: 'Unit 403',
  address_line_2: '1140 18th Ave',
  city: 'Denver',
  state: 'CO',
  zip: '80218'
)

3.times do |n|
  lease.tenants << User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "tenant#{n}@email.com",
    password: 'password',
    password_confirmation: 'password',
    role: 'tenant'
  )
end

User.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: "manager@email.com",
  password: 'password',
  password_confirmation: 'password',
  role: 'manager'
)
