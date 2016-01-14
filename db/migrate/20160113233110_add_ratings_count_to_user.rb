class AddRatingsCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :ratings_count, :integer, default: 0, null: false

    # update count and average for existing submissions
    User.where(role: ["Editor", "Admin"]).find_each do |e|
      User.reset_counters(e.id, :ratings)
    end

  end
end
