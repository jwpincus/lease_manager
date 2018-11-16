class ChangeAcceptedColumnOnAcceptances < ActiveRecord::Migration[5.1]
  def change
    change_column :acceptances, :accepted, :boolean, default: false
  end
end
