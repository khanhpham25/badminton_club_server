class ClubsController < ApplicationController
  before_action :find_club, except: [:index, :new, :create]

  def index
    @clubs = Club.all
  end

  def new
    @club = Club.new
  end

  def create
    @club = Club.new club_params
    if club.save
      flash[:success] = "Club created successfully"
      redirect_to club
    else
      flash[:danger] = "Fail to create club!"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if club.update_attributes club_params
      flash[:success] = "Update club sucessfully!"
      redirect_to club
    else
      flash[:danger] = "Fail to update club!"
      render :edit
    end
  end

  def destroy
    club.destroy
    flash[:success] = "Club is succesfully deleted!"
    redirect_to clubs_url
  end

  private

  attr_reader :club

  def club_params
    params.require(:club).permit Club::ATTRIBUTES_PARAMS
  end

  def find_club
    @club = Club.find_by id: params[:id]

    return if club
    flash[:warning] = "Couldn't find this club. Please try again!"
    redirect_to root_path
  end
end
