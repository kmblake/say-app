class CreateArtworks < ActiveRecord::Migration
  def change
    create_table :artworks do |t|
      t.string :title
      t.integer :user_id

      t.timestamps
    end
  end
end
