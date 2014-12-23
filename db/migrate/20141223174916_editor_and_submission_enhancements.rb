class EditorAndSubmissionEnhancements < ActiveRecord::Migration
  def change
    add_column :users, :approved, :boolean, default: false

    add_column :documents, :accepted, :boolean, default: false
    add_column :artworks, :accepted, :boolean, default: false
  end
end
