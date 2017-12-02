module Serializers
  module Api
    class ClubSerializer < Serializers::BaseSerializer
      attrs :id, :name, :avatar, :description, :average_level,
            :all_members_count, :is_recruiting, :allow_friendly_match,
            :location, :latitude, :longitude

      def all_members_count
        object.members.count + object.owners.count
      end
    end
  end
end
