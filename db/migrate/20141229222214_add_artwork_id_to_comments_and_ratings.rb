class AddArtworkIdToCommentsAndRatings < ActiveRecord::Migration
  def change
  	add_column :ratings, :artwork_id, :integer
  	add_column :comments, :artwork_id, :integer
  end
end
