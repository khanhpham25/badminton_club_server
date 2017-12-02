module Serializers
  module Api
    class UserSerializer < Serializers::BaseSerializer
      attrs :id, :name, :email, :mobile, :badminton_level, :avatar,
            :main_rackquet, :is_admin, :auth_token, :owned_club_ids,
            :member_club_ids, :requested_club_ids, :provider, :gender

      def avatar
        return unless object.avatar?
        Hash[:url, object.avatar.url]
      end

      def owned_club_ids
        object.owned_clubs.pluck(:id)
      end

      def member_club_ids
        object.joined_clubs.pluck(:id)
      end

      def requested_club_ids
        object.join_requests.where(accepted: nil).pluck(:club_id)
      end
    end
  end
end
