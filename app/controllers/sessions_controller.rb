class SessionsController < ApplicationController
  attr_reader :user

  def new; end

  def create
    @user = User.find_by email: params[:session][:email].downcase
    if user && user.valid_password?(params[:session][:password])
      log_in user
      user.generate_authentication_token!
      user.save
      flash[:success] = "Sign In Successfully"
      redirect_to root_url
    else
      flash[:danger] = "Invalid email/password combination"
      redirect_to root_url
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "Sign Out Successfully"
    redirect_to root_url
  end
end
