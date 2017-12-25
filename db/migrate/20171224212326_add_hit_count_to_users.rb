class AddHitCountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :hit_count, :integer
  end
end
