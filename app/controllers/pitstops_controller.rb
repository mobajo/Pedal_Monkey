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
    pitstop = Pitstop.find(params[:id])
    pitstop.update(pitstop_params)
    #find_places(@pitstop.latitude, @pitstop.longitude)
    redirect_to trip_path(trip)
  end

  def destroy
  end

  private

  def pitstop_params
    params.require(:pitstop).permit(:name, :address, :latitude, :longitude, :price, :rating, :start_stage_id, :end_stage_id)
  end

  def find_places(lat, lng)
        client = GooglePlaces::Client.new(ENV['GOOGLE_API_BROWSER_KEY'])
    spots = client.spots(lat, lng, :types => 'lodging')

    spot_array = []
    spots.each do |spot|
      spot_array << { lat: spot.lat, lng: spot.lng, name: spot.name, vicinity: spot.vicinity, rating: spot.rating }
    end
  end
end

