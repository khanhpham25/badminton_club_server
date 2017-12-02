module Serializers
  module Api
    class JoinRequestSerializer < Serializers::BaseSerializer
      attrs :user_id, :club_id, :accepted, :user

      def user
        Serializers::Api::UserSerializer.new(object: object.user).serializer
      end
    end
  end
end
