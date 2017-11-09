class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :mobile, :badminton_level, :avatar,
             :main_rackquet, :is_admin, :auth_token
end
