class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :mobile
      t.integer :badminton_level
      t.string :avatar
      t.string :main_rackquet
      t.boolean :is_admin
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
