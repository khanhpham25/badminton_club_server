module Api
  class ClubsController < ApplicationController
    before_action :authenticate_with_token!, only: %i[update destroy]
    before_action :find_club, only: %i[show update destroy]

    def index
      clubs = Club.all
      render json: {data: {clubs: clubs}}, status: :ok
    end

    def show
      render json: {data: {club: club}}, status: :ok
    end

    def create
      club = Club.new club_params
      if club.save
        render json: {
          message: "Club created succesfully!", data: {club: club}
        }, status: :created
      else
        render json: { errors: club.errors }, status: :unprocessable_entity
      end
    end

    def update
      if club.update_attributes club_params
        render json: {
          message: "Club updated succesfully!", data: {club: club}
        }, status: :ok
      else
        render json: { errors: club.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      club.destroy
      render json: {
        message: "Club has been deleted!"
      }, status: :no_content
    end

    private

    attr_reader :club

    def club_params
      params.require(:club).permit Club::ATTRIBUTES_PARAMS
    end

    def find_club
      @club = Club.find_by id: params[:id]

      return if club
      render json: {
        messages: "Club not found!"
      }, status: :not_found
    end
  end
end
