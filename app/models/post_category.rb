class PostCategory < ApplicationRecord
  act_as_paranoid

  ATTRIBUTES_PARAMS = %i[name].freeze

  has_many :posts, dependent: :destroy
end
