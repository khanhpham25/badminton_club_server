module Api
  class UserClubsController < ApplicationController
    before_action :authenticate_with_token!, only: %i[update destroy]
    before_action :find_user_club, only: %i[show update destroy]

    def index
      user_clubs = UserClub.all
      render json: user_clubs, status: :ok
    end

    def show
      render json: user_club, status: :ok
    end

    def create
      user_club = UserClub.new user_club_params
      if user_club.save
        render json: {
          message: "User Club created succesfully!", user_club: user_club
        }, status: :created, location: [:api, user_club]
      else
        render json: { errors: user_club.errors }, status: :unprocessable_entity
      end
    end

    def update
      if user_club.update_attributes club_params
        render json: {
          message: "User Club updated succesfully!", user_club: user_club
        }, status: :ok, location: [:api, user_club]
      else
        render json: { errors: user_club.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      user_club.destroy
      render json: {
        message: "User Club has been deleted!"
      }, status: :no_content
    end

    private

    attr_reader :user_club

    def user_club_params
      params.require(:user_club).permit UserClub::ATTRIBUTES_PARAMS
    end

    def find_user_club
      @user_club = UserClub.find_by id: params[:id]

      return if user_club
      render json: {
        messages: "User Club not found!"
      }, status: :not_found
    end
  end
end
