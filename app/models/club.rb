class Club < ApplicationRecord
  acts_as_paranoid
  mount_uploader :avatar, PictureUploader

  ATTRIBUTES_PARAMS = [
    :name, :avatar, :description, :average_level, :number_of_members,
    :is_recruiting, :allow_friendly_match, :location, :latitude, :longitude,
    user_clubs_attributes: UserClub::ATTRIBUTES_PARAMS
  ].freeze

  has_many :user_clubs, dependent: :destroy
  has_many :owner_user_clubs, -> { owner_user_clubs }, class_name: UserClub.name
  has_many :member_user_clubs, -> { member_user_clubs },
           class_name: UserClub.name
  has_many :posts, dependent: :destroy
  has_many :owners, through: :owner_user_clubs, source: :user
  has_many :members, through: :member_user_clubs, source: :user
  has_many :working_schedules, dependent: :destroy
  has_many :request, dependent: :destroy

  sort = lambda do |sort_type, current_user|
    if sort_type == "my_club"
      joins(:user_clubs).where(user_clubs: {user_id: current_user.id})
    elsif sort_type == "recruiting"
      where is_recruiting: true
    elsif sort_type == "friendly_match"
      where allow_friendly_match: true
    end
  end

  scope :sort_by, sort

  accepts_nested_attributes_for :user_clubs, allow_destroy: true,
    reject_if: proc{ |attributes| attributes[:user_id].blank? }
end
