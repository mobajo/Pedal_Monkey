class StagesController < ApplicationController
  def index
  end

  def show
    @user = current_user
    @trip = Trip.find(params[:trip_id])
    @stage = Stage.find(params[:id])
    @stages = @trip.stages
    @Elevation_samples = google_directions_elevation(@stage)
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

  def google_directions_elevation(stage)
    gmaps = GoogleMapsService::Client.new(key: ENV['GOOGLE_API_SERVER_KEY'])

    locations = [[stage.start_point.latitude, stage.start_point.longitude], [stage.end_point.latitude, stage.end_point.longitude]]
    results = gmaps.elevation_along_path(locations, 200)
    #raise

  end
end
