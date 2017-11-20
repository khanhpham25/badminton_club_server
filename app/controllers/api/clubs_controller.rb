module Api
  class ClubsController < ApplicationController
    before_action :authenticate_with_token!, only: %i[update destroy]
    before_action :find_club, only: %i[show update destroy]

    def index
      clubs = Club.all
      render json: {
        messages: "Load clubs successfully!", data: clubs, status: 200
      }, status: :ok
    end

    def show
      render json: {
        messages: "Load club succesfully!", data: club, status: 200
      }, status: :ok
    end

    def create
      club = Club.new club_params
      if club.save
        render json: {
          message: "Club created succesfully!", data: club, status: 201
        }, status: :created
      else
        render json: {
          errors: club.errors, status: 422
        }, status: :unprocessable_entity
      end
    end

    def update
      if club.update_attributes club_params
        render json: {
          message: "Club updated succesfully!", data: club, status: 200
        }, status: :ok
      else
        render json: {
          errors: club.errors, status: :unprocessable_entity
        }, status: :unprocessable_entity
      end
    end

    def destroy
      club.destroy
      render json: {message: "Club has been deleted!"}, status: :no_content
    end

    private

    attr_reader :club

    def club_params
      params.require(:club).permit Club::ATTRIBUTES_PARAMS
    end

    def find_club
      @club = Club.find_by id: params[:id]

      return if club
      render json: {errors: "Club not found!"}, status: :not_found
    end
  end
end
