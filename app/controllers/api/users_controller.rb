class Api::UsersController < ApplicationController
  before_action :authenticate_with_token!, only: %i[update destroy]
  before_action :find_user, only: %i[show update destroy]

  def index
    users = User.all
    render json: {
      messages: "Load Users succesfully", data: users, status: 200
    }, status: :ok
  end

  def show
    render json: {
      messages: "Load User succesfully", data: user, status: 200
    }, status: :ok
  end

  def create
    user = User.new user_params
    if user.save
      render json: {
        message: "User created succesfully!", data: user, status: 201
      }, status: :created
    else
      render json: {
        errors: user.errors, status: 422
      }, status: :unprocessable_entity
    end
  end

  def update
    if user.update_attributes user_params
      render json: {
        message: "User updated succesfully!", data: user, status: 200
      }, status: :ok
    else
      render json: {
        errors: user.errors, status: 422
      }, status: :unprocessable_entity
    end
  end

  def destroy
    user.destroy
    render json: {message: "User has been deleted!"}, status: :no_content
  end

  private

  attr_reader :user

  def user_params
    params.require(:user).permit User::ATTRIBUTES_PARAMS
  end

  def find_user
    @user = User.find_by id: params[:id]

    return if user
    render json: {errors: "User not found!"}, status: :not_found
  end
end
