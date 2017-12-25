class User < ApplicationRecord
  acts_as_paranoid
  mount_uploader :avatar, PictureUploader

  attr_accessor :reset_token

  before_save :downcase_email
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
  has_many :owned_clubs, through: :owner_user_clubs, source: :club
  has_many :joined_clubs, through: :member_user_clubs, source: :club
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :join_requests, dependent: :destroy

  validates :email, uniqueness: true
  validates :auth_token, uniqueness: true

  def increase_hit_count!
    self.hit_count = (hit_count || 0) + 1
  end

  def generate_authentication_token!
    self.auth_token = Devise.friendly_token
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attributes reset_digest: reset_token,
                      reset_sent_at: Time.zone.now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  class << self
     def digest string
       cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
         BCrypt::Engine.cost
       BCrypt::Password.create string, cost: cost
     end

     def new_token
       SecureRandom.urlsafe_base64
     end
   end

  private

  def downcase_email
    email.downcase!
  end
end
