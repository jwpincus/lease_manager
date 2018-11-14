class CreateLeaseUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :lease_users do |t|
      t.references :lease, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
