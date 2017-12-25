module Statistics
  class UsersController < ApplicationController
    def index
      @users = User.all
      oldest_date = User.order(:created_at).first.created_at
      time_interval = ((Time.now - oldest_date)/86400).round
      total_access = User.all.pluck(:hit_count).inject {|x, s| s += x}
      @access_per_day = total_access/time_interval
      beginner = User.where(badminton_level: 1).count
      amateur = User.where(badminton_level: 2).count
      pro = User.where(badminton_level: 3).count
      unknown = User.where(badminton_level: nil).count

      @data_set_user_level = {
        Beginner: beginner, Amateur: amateur, Professional: pro,
        Unknown: unknown
      }
      @data_set_user_by_month = {
        1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0,
        6 => 0, 7 => 0, 8 =>0, 9 => 0, 10 => 0, 11 => 0, 12 =>0
      }
      @data_set_user_by_month.merge! User.group("Month(created_at)").count
    end
  end
end
