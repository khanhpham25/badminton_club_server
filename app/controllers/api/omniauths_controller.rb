module Api
  class OmniauthsController < Devise::SessionsController
    skip_before_action :verify_authenticity_token

    def create
      user_email = params[:session][:email]
      user_auth_token = params[:session][:auth_token]
      user_provider = params[:session][:provider]

      user = User.where(email: user_email).first_or_create! do |user|
        user.email = user_email
        user.auth_token = user_auth_token
        user.provider = user_provider
      end

      return unless user.persisted?
      sign_in user, store: false
      render json: {data: user, status: 200}, status: 200
    end

    def destroy
      user = User.find_by auth_token: params[:auth_token]
      sign_out user
      user.generate_authentication_token!
      user.save
      head 204
    end
  end
end
