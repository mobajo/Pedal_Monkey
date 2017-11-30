class StagesController < ApplicationController
  def index
  end

  def show
    @user = current_user
    @trip = Trip.find(params[:trip_id])
    @stage = Stage.find(params[:id])
    @stages = @trip.stages
    @Elevation_samples = google_directions_elevation(@stage)
    @pitstop = @stage.end_point
    @hotels = find_places(@pitstop.latitude, @pitstop.longitude)


 #    if @pitstop.update(pitstop_params)
 #    #find_places(@pitstop.latitude, @pitstop.longitude)
 #    redirect_to trip_stage_path(@trip, @stage)
 #  else
 #   render :new
 # end
end

def new
end

def create
end

def update
  trip = Trip.find(params[:trip_id])
  stage = Stage.find(params[:stage_id])
  pitstop = Pitstop.find(params[:id])
  if pitstop.update(pitstop_params)
    raise
    #find_places(@pitstop.latitude, @pitstop.longitude)
    redirect_to trip_stage_path(trip, stage)
  else
   raise
   render :new
 end
end

def edit
end

def destroy
end

private

# def pitstop_params
#   params.require(:pitstop).permit(:name, :address, :stage_id, :latitude, :longitude, :price, :rating, :start_stage_id)
# end

def find_places(lat, lng)
  client = GooglePlaces::Client.new(ENV['GOOGLE_API_BROWSER_KEY'])
  spots = client.spots(lat, lng, :types => 'lodging')

  spot_array = []
  spots.each do |spot|
    spot_array << { lat: spot.lat, lng: spot.lng, name: spot.name, vicinity: spot.vicinity, rating: spot.rating }

  end
end

def google_directions_elevation(stage)
  gmaps = GoogleMapsService::Client.new(key: ENV['GOOGLE_API_BROWSER_KEY'])


  locations = [[stage.start_point.latitude, stage.start_point.longitude], [stage.end_point.latitude, stage.end_point.longitude]]
  results = gmaps.elevation_along_path(locations, 200)
    #raise

  end
end
