class Lease < ApplicationRecord
  validates_presence_of :amount
  validates_presence_of :starts_at
  validates_presence_of :ends_at
  validates :payment_day, presence: true, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 31}
  
  has_many :lease_users
  has_one :owner, -> { where(role: 'owner')}, through: :lease_users, class_name: 'User'
  has_many :managers, -> { where(role: 'managers')}, through: :lease_users, class_name: 'User'
  has_many :tenants, -> { where(role: 'tenants')}, through: :lease_users, class_name: 'User'
  
  def payment_day_this_month(month = Date.today.month)
    payment_day < Time.days_in_month(month) ? payment_day : Time.days_in_month(month)
  end
  
end