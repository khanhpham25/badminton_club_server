module Api
  class SessionsController < Api::BaseController
    skip_before_action :verify_authenticity_token

    def create
      user_password = params[:session][:password]
      user_email = params[:session][:email]
      user = user_email.present? && User.find_by(email: user_email)

      if user.present? && user.valid_password?(user_password)
        log_in user
        user.generate_authentication_token!
        user.increase_hit_count!
        user.save
        user_seri = Serializers::Api::UserSerializer
          .new(object: user).serializer
        render json: {data: user_seri, status: 200}, status: 200
      else
        render json: {
          errors: "Invalid email or password", status: 422
        }, status: 422
      end
    end

    def destroy
      user = User.find_by auth_token: params[:auth_token]
      log_out
      user.generate_authentication_token!
      user.save
      head 204
    end
  end
end
