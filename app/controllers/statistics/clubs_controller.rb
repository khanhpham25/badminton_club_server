module Statistics
  class ClubsController < ApplicationController
    def index
      @clubs = Club.all
      @not_registers = Club.where latitude: nil, longitude: nil

      beginner = Club.where(average_level: 1).count
      amateur = Club.where(average_level: 2).count
      pro = Club.where(average_level: 3).count
      unknown = Club.where(average_level: nil).count

      @data_set_club_level = {
        Beginner: beginner, Amateur: amateur, Professional: pro,
        Unknown: unknown
      }

      @friendly_match = Club.where allow_friendly_match: true
      @recruiting = Club.where is_recruiting: true
    end
  end
end
