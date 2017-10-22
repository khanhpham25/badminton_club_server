class Comment < ApplicationRecord

  ATTRIBUTES_PARAMS = %i[content user_id post_id].freeze

  belongs_to :post
  belongs_to :user
end
