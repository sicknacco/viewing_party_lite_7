# frozen_string_literal: true

class PartiesController < ApplicationController
  before_action :find_user_and_movie, only: %i[new create]
  before_action :require_user

  def new
    @party = Party.new
    @users = User.all
  end

  def create
    @party = Party.create!(party_params.merge(movie_id: @movie.id))
    PartyUser.create!(user_id: @user.id, party_id: @party.id, host: true)
    params[:participants].each do |_user_id|
      PartyUser.create!(party_user_params.merge(party_id: @party.id))
    end
    redirect_to dashboard_path(@user.id)
  end

  private

  def find_user_and_movie
    @user = User.find(params[:user_id])
    @movie = MovieFacade.get_movie(params[:movie_id])
  end

  def party_params
    params.require(:party).permit(:duration, :date, :time, :movie_id)
  end

  def party_user_params
    params.permit(:user_id, :party_id, :host)
  end

  def require_user
    unless current_user
      flash[:alert] = 'You must be logged in or registered to create a viewing party'
      redirect_to movie_path(@user.id, @movie.id)
    end
  end
end
