class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :role, :string
    add_column :users, :school, :string
    add_column :users, :grade, :integer
    add_column :users, :teacher, :string
    add_column :users, :bio, :text
  end
end
