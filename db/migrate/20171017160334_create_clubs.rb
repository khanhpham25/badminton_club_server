class CreateClubs < ActiveRecord::Migration[5.1]
  def change
    create_table :clubs do |t|
      t.string :name
      t.string :avatar
      t.text :description
      t.integer :average_level
      t.integer :number_of_members
      t.boolean :is_recruiting
      t.boolean :allow_friendly_match
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
