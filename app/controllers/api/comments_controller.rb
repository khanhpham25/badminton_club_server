module Api
  class CommentsController < ApplicationController
    before_action :authenticate_with_token!, only: %i[update destroy]
    before_action :find_comment, only: %i[show update destroy]

    def index
      comments = Comment.all
      render json: {
        messages: "Load comments succesfully", data: comments, status: 200
      }, status: :ok
    end

    def show
      render json: {
        messages: "Load comment succesfully", data: comment, status: 200
      }, status: :ok
    end

    def create
      comment = Comment.new comment_params
      if comment.save
        render json: {
          message: "Comment created succesfully!",
          data: comment, status: 201
        }, status: :created
      else
        render json: {
          errors: comment.errors, status: 422
        }, status: :unprocessable_entity
      end
    end

    def update
      if comment.update_attributes comment_params
        render json: {
          message: "Comment updated succesfully!", data: comment, status: 200
        }, status: :ok
      else
        render json: {
          errors: comment.errors, status: 422
        }, status: :unprocessable_entity
      end
    end

    def destroy
      comment.destroy
      render json: {message: "Comment has been deleted!"}, status: :no_content
    end

    private

    attr_reader :comment

    def comment_params
      params.require(:comment).permit Comment::ATTRIBUTES_PARAMS
    end

    def find_comment
      @comment = Comment.find_by id: params[:id]

      return if comment
      render json: {messages: "Comment not found!"}, status: :not_found
    end
  end
end
