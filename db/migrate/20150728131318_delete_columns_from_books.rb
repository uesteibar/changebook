class DeleteColumnsFromBooks < ActiveRecord::Migration
  def change
    remove_column :books, :date
    remove_column :books, :synopsis
  end
end
