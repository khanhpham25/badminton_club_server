class UserClub < ApplicationRecord

  ATTRIBUTES_PARAMS = %i[user_id club_id is_owner].freeze

  belongs_to :user
  belongs_to :club

  scope :owner_user_clubs, -> { where is_owner: true }
  scope :member_user_clubs, -> { where is_owner: false }
end
