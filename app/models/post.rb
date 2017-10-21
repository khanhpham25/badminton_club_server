class Post < ApplicationRecord
  act_as_paranoid

  ATTRIBUTES_PARAMS = %i[title content club_id post_category_id].freeze

  belongs_to :club, optional: true
  belongs_to :user
  belongs_to :post_category

  has_many :likes, dependent: :destroy
  has_many :comments, depedent: :destroy
end
