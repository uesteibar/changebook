class CreateEvents < ActiveRecord::Migration
  def change
    drop_table :events

    create_table :events do |t|
      t.integer   :user_id
      t.string   :item_urn

      t.timestamps null: false
    end
  end
end
