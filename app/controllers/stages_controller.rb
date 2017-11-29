class StagesController < ApplicationController
  def index
  end

  def show
    @user = current_user
    @trip = Trip.find(params[:trip_id])
    @stage = Stage.find(params[:id])
  end

  def new
  end

  def create
  end

  def update
  end

  def edit
  end

  def destroy
  end
end
