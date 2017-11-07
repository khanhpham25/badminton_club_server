module Api
  class PostCategoriesController < ApplicationController
    before_action :authenticate_with_token!, only: %i[update destroy]
    before_action :find_category, only: %i[show update destroy]

    def index
      categories = PostCategory.all
      render json: categories, status: :ok
    end

    def show
      render json: category, status: :ok
    end

    def create
      category = PostCategory.new category_params
      if category.save
        render json: {
          message: "Post Category created succesfully!", category: category
        }, status: :created, location: [:api, category]
      else
        render json: { errors: category.errors }, status: :unprocessable_entity
      end
    end

    def update
      if category.update_attributes category_params
        render json: {
          message: "Post Category updated succesfully!", category: category
        }, status: :ok, location: [:api, category]
      else
        render json: { errors: category.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      category.destroy
      render json: {
        message: "Post Category has been deleted!"
      }, status: :no_content
    end

    private

    attr_reader :category

    def category_params
      params.require(:category).permit PostCategory::ATTRIBUTES_PARAMS
    end

    def find_category
      @category = PostCategory.find_by id: params[:id]

      return if category
      render json: {
        messages: "Post Category not found!"
      }, status: :not_found
    end
  end
end
