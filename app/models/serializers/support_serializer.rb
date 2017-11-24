module Serializers
  class SupportSerializer < Serializers::BaseSerializer
    def object
      @object ||= nil
    end

    def supports
      @supports ||= nil
    end

    def ownerable
      @ownerable ||= nil
    end

    def organization
      @organization ||= nil
    end

    def course_subject
      @course_subject ||= nil
    end

    def course
      @course ||= nil
    end

    def courses
      @courses ||= nil
    end

    def subject_supports
      @subject_supports ||= nil
    end

    def course_subjects
      @course_subjects ||= nil
    end

    def show_program
      @show_program ||= nil
    end

    def question_results
      @question_results ||= nil
    end

    def results
      @results ||= nil
    end

    def show_correct
      @show_correct ||= nil
    end

    def user_static_task
      @user_static_task ||= nil
    end

    def user_dynamic_tasks
      @user_dynamic_tasks ||= nil
    end

    def current_user
      @current_user ||= nil
    end

    def user_subjects
      @user_subjects ||= nil
    end

    def objectable
      @objectable ||= nil
    end

    def team
      @team || nil
    end

    def task_id
      task =
        if objectable
          static_task = object.static_tasks
            .find_by ownerable: team || course_subject
          return nil unless static_task
          object.dynamic_tasks.find_by ownerable: course_subject,
            objectable: objectable, targetable: static_task
        else
          return nil unless ownerable
          ownerable.static_tasks.find_by targetable: object
        end
      task.id if task
    end
  end
end
