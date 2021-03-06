class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { scope: :role }
  validates :password, confirmation: true
  has_secure_password
  enum role: [:tenant, :manager, :owner]
  after_initialize :set_default_role, if: :new_record?
  after_initialize :check_for_invites, if: :new_record?
  has_many :lease_users
  has_many :leases, through: :lease_users, source: 'lease'
  has_many :acceptances, through: :lease_users, source: 'acceptance'

  def set_default_role
    self.role ||= :tenant
  end

  def check_for_invites
    invites = InvitedUser.where('LOWER(email) = ?', self.email).where(role: self.role)
    invites.each do |i|
      leases << i.lease
    end
    invites.delete_all
  end

  def name
    [first_name.capitalize, last_name.capitalize].join(' ')
  end

  def accept_lease!(lease)
    lease_users.find_by_lease_id(lease.id).acceptance.update(accepted: true)
  end

  def find_acceptance_by_lease(lease)
    lease_users.find_by_lease_id(lease.id).acceptance
  end

end
