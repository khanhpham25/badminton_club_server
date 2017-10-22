class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :user_id
      t.integer :post_id
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
