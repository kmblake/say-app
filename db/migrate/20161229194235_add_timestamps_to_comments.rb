class AddTimestampsToComments < ActiveRecord::Migration
  def change
    unless column_exists? :comments, :created_at 
      add_column :comments, :created_at, :datetime
    end
    unless column_exists? :comments, :updated_at 
      add_column :comments, :updated_at, :datetime
    end
  end
end
