class CreateGenres < ActiveRecord::Migration
  def change
    create_table :genres do |t|
      t.string    :name

      t.timestamps null: false
    end

    add_column :books, :genre_id, :integer, references: :genre, null: false
    add_index :books, :genre_id
  end
end
