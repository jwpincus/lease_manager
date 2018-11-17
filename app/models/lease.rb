class Lease < ApplicationRecord
  validates_presence_of :amount
  validates_presence_of :starts_at
  validates_presence_of :ends_at
  validates :payment_day, presence: true, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 31}

  has_many :lease_users

  has_one :owner_user, class_name: 'LeaseUser'
  has_one :owner, -> { where(role: 'owner')}, through: :owner_user, source: 'user'
  has_many :managers, -> { where(role: 'manager')}, through: :lease_users, source: 'user', class_name: 'User'
  has_many :tenants, -> { where(role: 'tenant')}, through: :lease_users, source: 'user'
  has_many :invited_users
  has_many :acceptances, through: :lease_users
  before_update :updatable?

  def payment_day_this_month(month = Date.today.month)
    payment_day < Time.days_in_month(month) ? payment_day : Time.days_in_month(month)
  end

  def add_user(role, email)
    user = User.find_by_role_and_email(role.to_s, email)
    if !user
      invited_users.create(email: email, role: role)
    elsif role == 'manager'
      managers << user
    elsif role == 'tenant'
      tenants << user
    end
  end

  def accepted_by_all?
    acceptances.pluck(:accepted).uniq == [true]
  end

  # extra callback method to ensure that leases can never be updated after acceptance, controller check exists as well
  def updatable?
    !accepted_by_all?
  end

end
