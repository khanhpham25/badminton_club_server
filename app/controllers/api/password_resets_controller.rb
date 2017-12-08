module Api
  class PasswordResetsController < Api::BaseController
    before_action :find_user, only: %i(edit update)
    before_action :check_expiration, only: %i(edit update)

    def create
      @user = User.find_by email: params[:password_reset][:email].downcase
      if user
        user.create_reset_digest
        user.send_password_reset_email
        render json: {
          message: "Email was sent with password reset instructions",
          status: 200
        }, status: :ok
      else
        render json: {errors: "Email address not found"}, status: :not_found
      end
    end

    def update
      if user.reset_digest == params[:user][:reset_digest]
        if params[:user][:password].empty?
          user.errors.add :password, "can't be empty"
          render json: {
            errors: user.errors, status: 422
          }, status: :unprocessable_entity
        elsif user.update_attributes user_params
          user.update_attributes reset_digest: nil
          render json: {
            messages: "Password has been reseted", status: 200
          }, status: :ok
        end
      else
        render json: {
          errors: "Invalid Reset Token", status: 422
        }, status: :unprocessable_entity
      end
    end

    private

    attr_reader :user

    def user_params
      params.require(:user).permit :reset_digest, :password,
                                   :password_confirmation
    end

    def find_user
      @user = User.find_by email: params[:email]
      return if user
      render json: {errors: "User not found"}, status: :not_found
    end

    def check_expiration
      if @user.password_reset_expired?
        render json: {
          errors: "Password reset has expired.", status: 422
        }, status: :unprocessable_entity
      end
    end
  end
end
