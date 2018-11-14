class CreateLeases < ActiveRecord::Migration[5.1]
  def change
    create_table :leases do |t|
      t.decimal :amount, scale: 2, precision: 10
      t.date :starts_at
      t.date :ends_at
      t.integer :payment_day

      t.timestamps
    end
  end
end
