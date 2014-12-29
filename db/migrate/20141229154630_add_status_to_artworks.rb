class AddStatusToArtworks < ActiveRecord::Migration
  def change
    add_column :artworks, :status, :string, default: Document::STATUS[:under_review]  end
end
