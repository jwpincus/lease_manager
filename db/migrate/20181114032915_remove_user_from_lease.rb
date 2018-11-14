class RemoveUserFromLease < ActiveRecord::Migration[5.1]
  def change
    remove_column :leases, :user_id, foreign_key: true
  end
end
