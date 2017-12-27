module Serializers
  module Api
    class MemberSerializer < Serializers::BaseSerializer
      attrs :id, :name, :mobile, :badminton_level, :avatar, :is_owner

      def avatar
        return unless object.avatar?
        Hash[:url, object.avatar.url]
      end

      def is_owner
        @club.owners.include? object
      end
    end
  end
end
