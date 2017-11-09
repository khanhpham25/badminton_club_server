module Api
  class PostsController < ApplicationController
    before_action :authenticate_with_token!, only: %i[update destroy]
    before_action :find_post, only: %i[show update destroy]

    def index
      posts = Post.all
      render json: {data: {posts: posts}}, status: :ok
    end

    def show
      render json: {data: {post: post}}, status: :ok
    end

    def create
      post = Post.new post_params
      if post.save
        render json: {
          message: "Post created succesfully!", data: {post: post}
        }, status: :created
      else
        render json: { errors: post.errors }, status: :unprocessable_entity
      end
    end

    def update
      if post.update_attributes post_params
        render json: {
          message: "Post updated succesfully!", data: {post: post}
        }, status: :ok
      else
        render json: { errors: post.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      post.destroy
      render json: {message: "Post has been deleted!"}, status: :no_content
    end

    private

    attr_reader :post

    def post_params
      params.require(:post).permit Post::ATTRIBUTES_PARAMS
    end

    def find_post
      @post = Post.find_by id: params[:id]

      return if post
      render json: {messages: "Post not found!"}, status: :not_found
    end
  end
end
