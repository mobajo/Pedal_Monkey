class TripsController < ApplicationController

  def index
  end

  def show
    @trip = Trip.find(params[:id])
    @stages = @trip.stages
    @trip_member = TripMember.new()

   # @average_stage_distance_km = @distance_in_km / (end_date.to_date - start_date.to_date).to_i
 end

 def new
 end

 def create

  start_address = params[:start]
  end_address = params[:finish]
  start_date = params[:start_date]
  end_date = params[:end_date]
  trip_name = params[:name]

  step_array = google_directions_locations(start_address, end_address, start_date, end_date)
 #   test_array = []
 #
 #   @doc.root.xpath("//step//distance//value").children.each do |child|
 #     test_array << child.text.to_i
 #   end
 # raise

 #  all_steps_without_total = all_steps.slice!(-1)

    ####### 1 INSTANTIATING A NEW TRIP
    @trip = Trip.new


    ####### 3 CREATING STAGES
    stage_no = 1
    @trip.set_stages(stage_no, start_date, end_date) # From Trip model


    ####### 4 CREATING PITSTOPS
    Pitstop.pitstops_create_first(@trip.stages.first, start_address)
    Pitstop.pitstops_create_rest(@trip, step_array)
    Pitstop.pitstops_create_last(@trip, end_address)
    #calculate stage distances
    @trip.stages.each(&:compute_distance)

    # SAVE AND RENDER THE TRIP IF NO ERRORS
    @trip.title = trip_name
    @trip.save
    @trip.update_distance
    @trip_member = TripMember.create(trip: @trip, user: current_user)
    if @trip.save
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @trip = Trip.find(params[:id])
    if @trip.update(trip_params)
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end

  def destroy
    @trip = Trip.find(params[:id])
    @trip.destroy
    redirect_to dashboard_path
  end

  private

  def trip_params
    params.require(:trip).permit(:title, :start_date, :end_date, :start_address, :end_address, :distance)
  end

  def google_directions_locations(start_address, end_address, start_date, end_date)

     #cycle_options = {
     # :language => :en,
     # :alternative => :false,   #changed by rm from false
     # :sensor => :false,
     # :mode => :bicycling
     # }
    # directions = GoogleDirections.new(start_address, end_address, cycle_options)
    gmaps = GoogleMapsService::Client.new(key: ENV['GOOGLE_API_BROWSER_KEY'])
    routes = gmaps.directions(start_address, end_address,
      mode: 'bicycling',
      alternatives: false)


    drive_time_in_minutes = routes[0][:legs][0][:duration][:value]
    distance_in_m = routes[0][:legs][0][:distance][:value]


    number_of_days = (end_date.to_date - start_date.to_date).to_i + 1
    total_trip_distance = distance_in_m
    pitstops_interval = total_trip_distance.fdiv(number_of_days).ceil

    pitstops_distance = (pitstops_interval..total_trip_distance).step(pitstops_interval).to_a


    totalmeters = 0
    step_array = []
    j = 0
   # array = []


   pitstop = pitstops_distance[j];

  routes[0][:legs][0][:steps].each do |step|
    break if j == pitstops_distance.count
    totalmeters += step[:distance][:value]
    if totalmeters > pitstop
      step_array << [step[:start_location][:lat], step[:start_location][:lng]]
      j += 1
      pitstop = pitstops_distance[j]
    end
  end

  return step_array
  end


  def google_directions_total_distance(start_address, end_address)
    gmaps = GoogleMapsService::Client.new(key: ENV['GOOGLE_API_BROWSER_KEY'])
    routes = gmaps.directions(start_address, end_address,
      mode: 'bicycling',
      alternatives: false)
    trip_total_km = routes[0][:legs][0][:steps][0][:distance][:value] / 1000
    return trip_total_km
  end

end
