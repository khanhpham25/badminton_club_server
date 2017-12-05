module Api
  class UserClubsController < ApplicationController
    before_action :authenticate_with_token!, only: %i[update destroy]
    before_action :find_user_club, only: %i[show update destroy]

    def index
      user_clubs = UserClub.all
      render json: {
        messages: "Load User Clubs succesfully!",
        data: user_clubs, status: 200
      }, status: :ok
    end

    def show
      render json: {
        messages: "Load User Club succesfully!",
        data: user_club, status: 200
      }, status: :ok
    end

    def create
      user_club = UserClub.new user_club_params
      if user_club.save
        join_request = JoinRequest.find_by user_id: user_club_params[:user_id],
                                           club_id: user_club_params[:club_id]
        join_request.destroy if join_request                                                    
        render json: {
          message: "User Club created succesfully!",
          data: user_club, status: 201
        }, status: :created
      else
        render json: {
          errors: user_club.errors, status: 422
        }, status: :unprocessable_entity
      end
    end

    def update
      if user_club.update_attributes club_params
        render json: {
          message: "User Club updated succesfully!",
          data: user_club, status: 200
        }, status: :ok
      else
        render json: {
          errors: user_club.errors, status: 422
        }, status: :unprocessable_entity
      end
    end

    def destroy
      user_club.destroy
      render json: {message: "User Club has been deleted!"}, status: :no_content
    end

    private

    attr_reader :user_club

    def user_club_params
      params.require(:user_club).permit UserClub::ATTRIBUTES_PARAMS
    end

    def find_user_club
      @user_club = UserClub.find_by user_id: params[:user_id],
                                    club_id: params[:club_id]

      return if user_club
      render json: {messages: "User Club not found!"}, status: :not_found
    end
  end
end
