class CreateInvitedUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :invited_users do |t|
      t.references :lease, foreign_key: true
      t.string :role
      t.string :email

      t.timestamps
    end
  end
end
