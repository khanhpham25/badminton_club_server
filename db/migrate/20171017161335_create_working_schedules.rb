class CreateWorkingSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :working_schedules do |t|
      t.datetime :working_date
      t.integer :club_id
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
