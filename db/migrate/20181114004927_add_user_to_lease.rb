class AddUserToLease < ActiveRecord::Migration[5.1]
  def change
    add_reference :leases, :user, foreign_key: true
  end
end
