class ClubSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar, :description, :average_level,
    :number_of_members, :is_recruiting, :allow_friendly_match,
    :location, :latitude, :longitude
end
