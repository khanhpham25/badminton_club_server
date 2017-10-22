class User < ApplicationRecord
  ATTRIBUTES_PARAMS = %i[
    name email mobile badminton_level avatar main_rackquet is_admin
  ].freeze

  has_many :owner_user_clubs, -> { owner_user_clubs }, class_name: UserClub.name
  has_many :member_user_clubs, -> { member_user_clubs },
           class_name: UserClub.name
  has_many :owned_clubs, through: :owner_user_clubs, class_name: Club.name
  has_many :joined_clubs, through: :member_user_clubs, class_name: Club.name
  has_many :posts, depedent: :destroy
  has_many :comments, depedent: :destroy
  has_many :likes, depedent: :destroy
end
