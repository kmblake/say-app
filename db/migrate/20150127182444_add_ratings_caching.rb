class AddRatingsCaching < ActiveRecord::Migration
  def up
    add_column :documents, :ratings_count, :integer, default: 0, null: false
    add_column :documents, :average_rating, :float
    add_column :artworks, :ratings_count, :integer, default: 0, null: false
    add_column :artworks, :average_rating, :float
    
    # update count and average for existing submissions
    Document.find_each do |doc|
      Document.reset_counters(doc.id, :ratings)
      doc.update_average
    end

    Artwork.find_each do |art|
      Artwork.reset_counters(art.id, :ratings)
      art.update_average
    end
  end

  def down
    remove_column :documents, :ratings_count
    remove_column :documents, :average_rating
    remove_column :artworks, :ratings_count
    remove_column :artworks, :average_rating
  end
end
