class Api::MembersController < Api::BaseController
  before_action :find_club

  def index
    all_members = club.owners + club.members
    members = Serializers::Api::MemberSerializer.new(
      object: all_members, scope: {club: club}).new
    render json: {
      messages: "Load Members succesfully", data: members, status: 200
    }, status: :ok
  end

  private

  attr_reader :club

  def find_club
    @club = Club.find_by id: params[:club_id]

    return if club
    render json: {errors: "Club not found!"}, status: :not_found
  end
end
