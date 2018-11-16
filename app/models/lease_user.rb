class LeaseUser < ApplicationRecord
  belongs_to :lease
  belongs_to :user
  belongs_to :acceptance, optional: true
  after_create :create_acceptance, if: :user_is_tenant?

  def user_is_tenant?
    self.user.tenant?
  end

  def create_acceptance
    self.acceptance = Acceptance.create
    self.save
  end

end
