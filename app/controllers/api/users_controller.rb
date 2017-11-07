class Api::UsersController < ApplicationController
  before_action :authenticate_with_token!, only: %i[update destroy]
  before_action :find_user, only: %i[show update destroy]

  def index
    users = User.all
    render json: users, status: :ok
  end

  def show
    render json: user, status: :ok
  end

  def create
    user = User.new user_params
    if user.save
      render json: {message: "User created succesfully!", user: user},
        status: :created, location: [:api, user]
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  def update
    if user.update_attributes user_params
      render json: {message: "User updated succesfully!", user: user},
        status: :ok, location: [:api, user]
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    user.destroy
    render json: {message: "User has been deleted!"},
      status: :no_content
  end

  private

  attr_reader :user

  def user_params
    params.require(:user).permit User::ATTRIBUTES_PARAMS
  end

  def find_user
    @user = User.find_by id: params[:id]

    return if user
    render json: {
      messages: "User not found!"
    }, status: :not_found
  end
end
