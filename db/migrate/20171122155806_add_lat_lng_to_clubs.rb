class AddLatLngToClubs < ActiveRecord::Migration[5.1]
  def change
    add_column :clubs, :latitude, :decimal, precision: 64, scale: 12
    add_column :clubs, :longitude, :decimal, precision: 64, scale: 12
  end
end
