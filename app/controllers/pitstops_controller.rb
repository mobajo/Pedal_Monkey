class PitstopsController < ApplicationController
  def show
  end

  def new
    @pitstop = Pitstop.find(params[:id])
  end

  def create
  end


  def edit
    @trip = Trip.find(params[:trip_id])
    @pitstop = Pitstop.find(params[:id])
    @hotels = find_places(@pitstop.latitude, @pitstop.longitude)

  end

  def update
    trip = Trip.find(params[:trip_id])
    stage = Stage.find(params[:stage_id])
    pitstop = Pitstop.find(params[:id])
    if pitstop.update(pitstop_params)
    #find_places(@pitstop.latitude, @pitstop.longitude)
    stage.compute_distance
    redirect_to trip_stage_path(trip, stage)
    else
     render :new
    end
end

def destroy
end

private

def pitstop_params
  params.require(:pitstop).permit(:name, :address, :stage_id, :latitude, :longitude, :price, :rating, :start_stage_id)
end

def find_places(lat, lng)
  client = GooglePlaces::Client.new(ENV['GOOGLE_API_BROWSER_KEY'])
  spots = client.spots(lat, lng, types: 'lodging')

  spot_array = []
  spots.each do |spot|
    spot_array << { lat: spot.lat, lng: spot.lng, name: spot.name, vicinity: spot.vicinity, rating: spot.rating }

  end
end
end

