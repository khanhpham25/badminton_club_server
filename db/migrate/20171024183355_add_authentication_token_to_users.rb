class AddAuthenticationTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :auth_token, :string, default: '', limit: 30
    add_index :users, :auth_token, unique: true, using: 'btree'
  end
end
