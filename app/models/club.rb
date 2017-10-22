class Club < ApplicationRecord
  act_as_paranoid

  ATTRIBUTES_PARAMS = %i[
    name avatar description average_level number_of_members is_recruiting
    allow_friendly_match
  ].freeze

  has_many :owner_user_clubs, -> { owner_user_clubs }, class_name: UserClub.name
  has_many :member_user_clubs, -> { member_user_clubs },
           class_name: UserClub.name
  has_many :posts, dependent: :destroy
  has_many :owners, through: :owner_user_clubs, class_name: User.name
  has_many :members, through: :member_user_clubs, class_name: User.name
  has_many :working_schedules, dependent: :destroy
end
