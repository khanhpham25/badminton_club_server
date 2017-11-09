module Api
  class WorkingSchedulesController < ApplicationController
    before_action :authenticate_with_token!, only: %i[update destroy]
    before_action :find_working_schedule, only: %i[show update destroy]

    def index
      working_schedules = WorkingSchedule.all
      render json: {
        messages: "Load Working Schedules",
        data: working_schedules, status: 200
      }, status: :ok
    end

    def show
      render json: {
        messages: "Load Working Schedule",
        data: working_schedule, status: 200
      }, status: :ok
    end

    def create
      working_schedule = WorkingSchedule.new working_schedule_params
      if working_schedule.save
        render json: {
          message: "Working Schedule created succesfully!",
          data: working_schedule, status: 201
        }, status: :created
      else
        render json: {
          errors: working_schedule.errors, status: 422
        }, status: :unprocessable_entity
      end
    end

    def update
      if working_schedule.update_attributes working_schedule_params
        render json: {
          message: "Working Schedule updated succesfully!",
          data: working_schedule, status: :ok
        }, status: :ok
      else
        render json: {
          errors: working_schedule.errors, status: 422
        }, status: :unprocessable_entity
      end
    end

    def destroy
      working_schedule.destroy
      render json: {
        message: "Working Schedule has been deleted!"
      }, status: :no_content
    end

    private

    attr_reader :working_schedule

    def working_schedule_params
      params.require(:working_schedule).permit
        WorkingSchedule::ATTRIBUTES_PARAMS
    end

    def find_working_schedule
      @working_schedule = WorkingSchedule.find_by id: params[:id]

      return if working_schedule
      render json: {
        messages: "Working Schedule not found!"
      }, status: :not_found
    end
  end
end
