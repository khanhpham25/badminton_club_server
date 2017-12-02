module Serializers
  module Api
    class BaseUserSerializer < Serializers::BaseSerializer
      attrs :id, :name, :email

      def avatar
        return unless object.avatar?
        Hash[:url, object.avatar.url]
      end
    end
  end
end
