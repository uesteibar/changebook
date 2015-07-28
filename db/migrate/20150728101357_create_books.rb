class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string    :title
      t.string    :synopsis
      t.string    :author
      t.date      :date
      t.string    :image_url
      t.boolean   :to_give_away
      t.boolean   :to_exchange
      t.integer   :user_id

      t.timestamps null: false
    end

    add_index :books, :user_id
  end
end
