class User < ApplicationRecord
  mount_uploader :avatar, PictureUploader

  before_create :generate_authentication_token!

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  ATTRIBUTES_PARAMS = %i[
    name email mobile badminton_level avatar main_rackquet is_admin
    gender password password_confirmation provider
  ].freeze

  has_many :owner_user_clubs, -> { owner_user_clubs }, class_name: UserClub.name
  has_many :member_user_clubs, -> { member_user_clubs },
           class_name: UserClub.name
  has_many :owned_clubs, through: :owner_user_clubs, class_name: Club.name
  has_many :joined_clubs, through: :member_user_clubs, class_name: Club.name
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :auth_token, uniqueness: true

  def generate_authentication_token!
    self.auth_token = Devise.friendly_token
  end
end
