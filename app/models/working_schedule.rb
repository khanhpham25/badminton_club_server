class WorkingSchedule < ApplicationRecord
  ATTRIBUTES_PARAMS = %i[working_date club_id].freeze

  belongs_to :club
end
