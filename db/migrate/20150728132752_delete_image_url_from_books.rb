class DeleteImageUrlFromBooks < ActiveRecord::Migration
  def change
    remove_column :books, :image_url
  end
end
