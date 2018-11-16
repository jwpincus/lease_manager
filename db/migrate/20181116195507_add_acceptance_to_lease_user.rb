class AddAcceptanceToLeaseUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :lease_users, :acceptance, foreign_key: true
  end
end
