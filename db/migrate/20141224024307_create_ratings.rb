class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
		t.integer :rating_val
    end
  end
end
