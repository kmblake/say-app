class AddFlagsToSubmissions < ActiveRecord::Migration
  def change
    add_column :documents, :flag, :boolean, default: false
    add_column :artworks, :flag, :boolean, default: false
  end
end
