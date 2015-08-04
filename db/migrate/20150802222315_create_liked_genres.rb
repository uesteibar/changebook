class CreateLikedGenres < ActiveRecord::Migration
  def change
    create_table :liked_genres do |t|
      t.integer   :user_id, null: false
      t.integer   :genre_id, null: false

      t.timestamps null: false
    end

    add_index :liked_genres, :user_id
    add_index :liked_genres, :genre_id
  end
end
