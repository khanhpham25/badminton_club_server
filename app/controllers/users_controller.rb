class UsersController < ApplicationController
  before_action :find_user, except: [:index, :new, :create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if user.save
      flash[:success] = "User created successfully"
      redirect_to user
    else
      flash[:danger] = "Fail to create user!"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if user.update_attributes user_params
      flash[:success] = "Update user sucessfully!"
      redirect_to user
    else
      flash[:danger] = "Fail to update user!"
      render :edit
    end
  end

  private

  attr_reader :user

  def user_params
    params.require(:user).permit User::ATTRIBUTES_PARAMS
  end

  def find_user
    @user = User.find_by id: params[:id]

    return if user
    flash[:warning] = "Couldn't find this user. Please try again!"
    redirect_to root_path
  end
end
