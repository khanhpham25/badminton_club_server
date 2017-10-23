class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  ATTRIBUTES_PARAMS = %i[
    name email mobile badminton_level avatar main_rackquet is_admin
  ].freeze

  has_many :owner_user_clubs, -> { owner_user_clubs }, class_name: UserClub.name
  has_many :member_user_clubs, -> { member_user_clubs },
           class_name: UserClub.name
  has_many :owned_clubs, through: :owner_user_clubs, class_name: Club.name
  has_many :joined_clubs, through: :member_user_clubs, class_name: Club.name
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
end
