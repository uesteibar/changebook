class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.integer   :user_id
      t.integer   :dest_user_id
      t.integer   :book_id
      t.boolean   :accepted

      t.timestamps null: false
    end

    add_index :transfers, :user_id
    add_index :transfers, :dest_user_id
    add_index :transfers, :book_id
  end
end
