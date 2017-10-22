class Like < ApplicationRecord
  ATTRIBUTES_PARAMS = %i[post_id user_id].freeze

  belongs_to :user
  belongs_to :post
end
