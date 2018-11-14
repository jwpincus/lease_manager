class AddAddressToLease < ActiveRecord::Migration[5.1]
  def change
    add_column :leases, :address_line_1, :string
    add_column :leases, :address_line_2, :string
    add_column :leases, :city, :string
    add_column :leases, :state, :string
    add_column :leases, :zip, :string
  end
end
