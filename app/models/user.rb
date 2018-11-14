class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: true
  has_secure_password
  enum role: [:tenant, :manager, :owner]
  after_initialize :set_default_role, :if => :new_record?
  has_many :lease_users
  has_many :leases, through: :lease_users

  def set_default_role
    self.role ||= :user
  end
  
  def name
    [first_name.capitalize, last_name.capitalize].join(' ')
  end
  
end
