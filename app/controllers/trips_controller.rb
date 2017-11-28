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


    step_array = google_directions(start_address, end_address, start_date, end_date)

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

    # SAVE AND RENDER THE TRIP IF NO ERRORS
    @trip.save
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
  end

  def destroy
  end

  private

  def google_directions(start_address, end_address, start_date, end_date)
     cycle_options = {
      :language => :en,
      :alternative => :true,
      :sensor => :false,
      :mode => :bicycling
      }
    directions = GoogleDirections.new(start_address, end_address, cycle_options)
    drive_time_in_minutes = directions.drive_time_in_minutes
    distance_in_m = directions.distance.to_i
    xml = directions.xml
    @doc = Nokogiri::XML(xml)

    raise

    number_of_days = (end_date.to_date - start_date.to_date).to_i
    number_of_pitstops = number_of_days + 1
    total_trip_distance = distance_in_m
    pitstops_interval = total_trip_distance / number_of_days
    # pitstops_distance = [pitstops_interval]

    pitstops_distance = (0..total_trip_distance).step(pitstops_interval).to_a
    # i = pitstops_distance;
    #   while i.length <= (number_of_pitstops)
    #     i << (pitstops_interval += pitstops_interval)
    #   end

   # pitstops_distance.slice!(-1)
   # pitstops_distance.slice!(0)


    totalmeters = 0
    step_array = []
    j = 0
   # array = []

    pitstop = pitstops_distance[j];

    @doc.root.xpath("//step").each do |child|
      break if j == pitstops_distance.count
      totalmeters += child.xpath('distance//value').text.to_i
    #  array << child.xpath('distance//value').text.to_i
      if totalmeters > pitstop
        step_array << [child.xpath('start_location//lat').text.to_f, child.xpath('start_location//lng').text.to_f]
        j += 1
        pitstop = pitstops_distance[j]
      end
    end
   # raise

    return step_array
  end
end
