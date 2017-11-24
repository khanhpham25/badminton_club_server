class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.integer :user_id
      t.integer :club_id
      t.boolean :accepted
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
