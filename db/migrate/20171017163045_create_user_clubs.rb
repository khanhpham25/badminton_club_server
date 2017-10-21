class CreateUserClubs < ActiveRecord::Migration[5.1]
  def change
    create_table :user_clubs do |t|
      t.integer :user_id
      t.integer :club_id
      t.boolean :is_owner

      t.timestamps
    end
  end
end
