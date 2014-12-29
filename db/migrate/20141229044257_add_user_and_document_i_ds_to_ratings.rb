class AddUserAndDocumentIDsToRatings < ActiveRecord::Migration
  def change
  	add_column :ratings, :document_id, :integer
  	add_column :ratings, :user_id, :integer
  	add_column :comments, :document_id, :integer
  	add_column :comments, :user_id, :integer
  end
end
