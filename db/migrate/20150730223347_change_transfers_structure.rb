class ChangeTransfersStructure < ActiveRecord::Migration
  def change
    remove_column :transfers, :dest_user_id
    remove_column :transfers, :book_id
    add_column :transfers, :ownership_id, :integer
    add_index :transfers, :ownership_id
  end
end
