module Api
  class JoinRequestsController < ApplicationController
    before_action :authenticate_with_token!, only: %i[update destroy]
    before_action :find_join_request, only: %i[show update destroy]

    def index
      join_requests = JoinRequest.all
      render json: {
        messages: "Load join_requests successfully!",
        data: join_requests, status: 200
      }, status: :ok
    end

    def create
      join_request = JoinRequest.new join_request_params
      if join_request.save
        render json: {
          message: "JoinRequest sent. Please wait for club owner's response",
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
          message: "JoinRequest updated succesfully!",
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
      render json: {message: "JoinRequest has been deleted!"}, status: :no_content
    end

    private

    attr_reader :join_request

    def join_request_params
      params.require(:join_request).permit JoinRequest::ATTRIBUTES_PARAMS
    end

    def find_join_request
      @join_request = JoinRequest.find_by id: params[:id]

      return if join_request
      render json: {errors: "JoinRequest not found!"}, status: :not_found
    end
  end
end
