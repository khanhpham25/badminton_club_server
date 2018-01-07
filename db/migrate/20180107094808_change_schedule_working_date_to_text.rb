class ChangeScheduleWorkingDateToText < ActiveRecord::Migration[5.1]
  def up
    change_column :working_schedules, :working_date, :text
  end

  def down
    change_column :working_schedules, :working_date, :datetime
  end
end
