class CreateThanks < ActiveRecord::Migration
  def up
    create_table :thanks do |t|
      t.integer   :user_id
      t.integer   :recommendation_id

      t.timestamps null: false
    end

    add_index :thanks, :user_id
    add_index :thanks, :recommendation_id
  end

  def down
    drop_table :thanks
  end
end
