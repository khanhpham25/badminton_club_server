class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :club_id
      t.integer :post_category_id
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
