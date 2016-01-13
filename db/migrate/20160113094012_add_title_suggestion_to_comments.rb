class AddTitleSuggestionToComments < ActiveRecord::Migration
  def change
    add_column :comments, :title_suggestion, :boolean
  end
end
