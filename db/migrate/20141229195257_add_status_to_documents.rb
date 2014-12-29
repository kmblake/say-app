class AddStatusToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :status, :string, default: Document::STATUS[:under_review]
  end
end
