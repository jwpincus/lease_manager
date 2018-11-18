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
    (acceptances.pluck(:accepted).uniq == [true]) && (invited_users.where(role: 'tenant').count == 0)
  end

  # extra callback method to ensure that leases can never be updated after acceptance, controller check exists as well. A bit unnecessary right now, but can add additional locking factors later
  def updatable?
    !accepted_by_all?
  end

  def revenue_by_all_months
    months = Hash.new { |hash, key| hash[key] = {} }
    date_pointer = starts_at.beginning_of_month + 1.month
    months[starts_at.strftime('%Y')][starts_at.strftime('%B')] = start_month_rent
    until date_pointer > ends_at
      months[date_pointer.strftime('%Y')][date_pointer.strftime('%B')] = amount
      date_pointer = date_pointer + 1.month
    end
    months[ends_at.strftime('%Y')][ends_at.strftime('%B')] = last_month_rent
    return months
  end

  def start_month_rent
    return amount if starts_at.day == 1
    days_in_month = Time.days_in_month(starts_at.month)
    return (amount * ((days_in_month - starts_at.day).to_d/days_in_month.to_d)).round(2)
  end

  def last_month_rent
    days_in_month = Time.days_in_month(ends_at.month)
    return (amount * (ends_at.day.to_d/days_in_month.to_d)).round(2)
  end

  def total_revenu

  end


end
