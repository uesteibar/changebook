class AddValorationToRecommendations < ActiveRecord::Migration
  def change
    add_column :recommendations, :valoration, :integer
  end
end
