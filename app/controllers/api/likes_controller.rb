module Api
  class LikesController < ApplicationController
    before_action :authenticate_with_token!, only: %i[update destroy]
    before_action :find_like, only: %i[show update destroy]

    def index
      likes = Like.all
      render json: likes, status: :ok
    end

    def show
      render json: like, status: :ok
    end

    def create
      like = Like.new like_params
      if like.save
        render json: {
          message: "Like created succesfully!", like: like
        }, status: :created, location: [:api, like]
      else
        render json: { errors: like.errors }, status: :unprocessable_entity
      end
    end

    def update
      if like.update_attributes like_params
        render json: {
          message: "Like updated succesfully!", like: like
        }, status: :ok, location: [:api, like]
      else
        render json: { errors: like.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      like.destroy
      render json: {
        message: "Like has been deleted!"
      }, status: :no_content
    end

    private

    attr_reader :like

    def like_params
      params.require(:like).permit Like::ATTRIBUTES_PARAMS
    end

    def find_like
      @like = Like.find_by id: params[:id]

      return if like
      render json: {
        messages: "Like not found!"
      }, status: :not_found
    end
  end
end
