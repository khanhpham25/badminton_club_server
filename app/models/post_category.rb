class PostCategory < ApplicationRecord
  acts_as_paranoid

  ATTRIBUTES_PARAMS = %i[name].freeze

  has_many :posts, dependent: :destroy
end
