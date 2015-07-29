class AddIndexesToRecommendations < ActiveRecord::Migration
  def change
    change_column :recommendations, :user_id, :integer, null: false
    change_column :recommendations, :book_id, :integer, null: false
    change_column :recommendations, :comment, :text, null: false

    add_index :recommendations, :user_id
    add_index :recommendations, :book_id
  end
end
