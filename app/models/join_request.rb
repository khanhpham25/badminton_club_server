class JoinRequest < ApplicationRecord
  ATTRIBUTES_PARAMS = [:user_id, :club_id, :accepted].freeze

  belongs_to :user
  belongs_to :club
end
