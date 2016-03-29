class AddFlagsToSubmissions < ActiveRecord::Migration
  def change
    add_column :documents, :flag, :boolean
    add_column :artworks, :flag, :boolean
  end
end
