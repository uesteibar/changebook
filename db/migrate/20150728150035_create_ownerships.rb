class CreateOwnerships < ActiveRecord::Migration
  def change
    create_table :ownerships do |t|
      t.integer   :user_id
      t.integer   :book_id
      t.boolean   :to_give_away
      t.boolean   :to_exchange

      t.timestamps null: false
    end

    remove_column :books, :user_id
    remove_column :books, :to_give_away
    remove_column :books, :to_exchange
  end
end
