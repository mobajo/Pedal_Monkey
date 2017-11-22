class TripsController < ApplicationController
  
  def index
    @trip = Trip.first
    @average_stage_length = []
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
