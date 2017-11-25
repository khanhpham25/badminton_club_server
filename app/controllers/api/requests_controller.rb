module Api
  class RequestsController < ApplicationController
    before_action :authenticate_with_token!, only: %i[update destroy]
    before_action :find_request, only: %i[show update destroy]

    def index
      requests = Request.all
      render json: {
        messages: "Load requests successfully!", data: requests, status: 200
      }, status: :ok
    end

    def create
      request = Request.new request_params
      if request.save
        render json: {
          message: "Request sent. Please wait for club owner's response",
          data: request, status: 201
        }, status: :created
      else
        render json: {
          errors: request.errors, status: 422
        }, status: :unprocessable_entity
      end
    end

    def update
      if request.update_attributes request_params
        render json: {
          message: "Club updated succesfully!", data: request, status: 200
        }, status: :ok
      else
        render json: {
          errors: request.errors, status: :unprocessable_entity
        }, status: :unprocessable_entity
      end
    end

    def destroy
      request.destroy
      render json: {message: "Club has been deleted!"}, status: :no_content
    end

    private

    attr_reader :request

    def request_params
      params.require(:request).permit Request::ATTRIBUTES_PARAMS
    end

    def find_request
      @request = Club.find_by id: params[:id]

      return if request
      render json: {errors: "Club not found!"}, status: :not_found
    end
  end
end
