require 'rails_helper'

RSpec.describe Lease, type: :model do

  it "is valid with valid attributes" do
    owner = create(:owner)
    expect(owner.leases.new(
      starts_at: Date.today,
      ends_at: Date.today + 1.year,
      payment_day: 1,
      amount: 1500.00
      )).to be_valid
  end
  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:starts_at) }
  it { should validate_presence_of(:ends_at) }
  it { should validate_presence_of(:payment_day) }
  it { should have_one(:owner)}
  it { should have_many(:managers)}
  it { should have_many(:tenants)}
  it { should have_many(:acceptances)}
  it { should validate_numericality_of(:payment_day).is_less_than_or_equal_to(31)}
  it { should validate_numericality_of(:payment_day).is_greater_than_or_equal_to(1)}
  it "can figure out the payment date for shorter months" do
    lease = Lease.new(payment_day: 31)
    expect(lease.payment_day_this_month(2)).to eq(28)
  end

  it "should create acceptances when a tenant is added" do
    lease = create(:lease)
    lease.tenants = create_list(:user, 2)
    expect(lease.acceptances.count).to eq(2)
  end
end
