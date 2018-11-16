class Acceptance < ApplicationRecord
  has_one :lease_user
  has_one :tenant, -> {where(role: 'tenant')}, through: :lease_user, source: 'user'
  has_one :lease, through: :lease_user
end
