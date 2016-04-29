class AddMoreCountsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :documents_count, :integer, default: 0, null: false
    add_column :users, :artworks_count, :integer, default: 0, null: false

    Submitter.find_each do |e|
      Submitter.reset_counters(e.id, :documents, :artworks)
    end
  end
end
