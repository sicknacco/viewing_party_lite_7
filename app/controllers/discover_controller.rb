class DiscoverController < ApplicationController
  before_action :find_user, only: [:index]

  private
  def find_user
    @user = User.find(params[:id])
  end
end