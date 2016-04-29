class AddCountsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :accepted_doc_count, :integer, default: 0, null: false
    add_column :users, :accepted_art_count, :integer, default: 0, null: false
    # update count for exisiting submissions
    Submitter.find_each do |e|
      e.update_columns(accepted_doc_count: e.documents.where(accepted:true).count, accepted_art_count: e.artworks.where(accepted:true).count)
    end
  end
end
