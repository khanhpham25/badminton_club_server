module Api
  class JoinRequestsController < Api::BaseController
    before_action :authenticate_with_token!, only: %i[update destroy]
    before_action :find_join_request, only: %i[show update destroy]
    before_action :find_club, only: :index

    def index
      join_requests = Serializers::Api::JoinRequestSerializer
        .new(object: club.join_requests).serializer
      render json: {
        messages: "Load join_requests successfully!",
        data: join_requests, status: 200
      }, status: :ok
    end

    def create
      join_request = JoinRequest.new join_request_params
      if join_request.save
        render json: {
          message: "Request Sent. Please Wait For Club Owner's Response",
          data: join_request, status: 201
        }, status: :created
      else
        render json: {
          errors: join_request.errors, status: 422
        }, status: :unprocessable_entity
      end
    end

    def update
      if join_request.update_attributes join_request_params
        render json: {
          message: "Join Request updated succesfully!",
          data: join_request, status: 200
        }, status: :ok
      else
        render json: {
          errors: join_request.errors, status: :unprocessable_entity
        }, status: :unprocessable_entity
      end
    end

    def destroy
      join_request.destroy
      render json: {message: "Join Request has been deleted!"}, status: :no_content
    end

    private

    attr_reader :join_request, :club

    def join_request_params
      params.require(:join_request).permit JoinRequest::ATTRIBUTES_PARAMS
    end

    def find_join_request
      @join_request = JoinRequest.find_by user_id: params[:user_id],
                                          club_id: params[:club_id]

      return if join_request
      render json: {errors: "Join Request not found!"}, status: :not_found
    end

    def find_club
      @club = Club.find_by id: params[:club_id]

      return if club
      render json: {errors: "Club not found!"}, status: :not_found
    end
  end
end
