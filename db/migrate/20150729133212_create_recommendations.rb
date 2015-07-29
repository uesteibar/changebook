class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.integer   :user_id
      t.integer   :book_id
      t.text      :comment

      t.timestamps null: false
    end
  end
end
