class TripsController < ApplicationController
  def index
  end

  def show
    @trip = Trip.where.not(latitude: nil, longitude: nil)

    @hash = Gmaps4rails.build_markers(@trip) do |flat, marker|
      marker.lat flat.latitude
      marker.lng flat.longitude
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
