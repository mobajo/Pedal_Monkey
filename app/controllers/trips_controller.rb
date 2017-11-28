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

    #fetches data from Directions api in XML format. Data is directions for trip between A and B from homepge form.

    directions = GoogleDirections.new(start_address, end_address)
    drive_time_in_minutes = directions.drive_time_in_minutes
    @distance_in_m = directions.distance.to_i
    @distance_in_km = @distance_in_m / 1000
    xml = directions.xml
    @doc = Nokogiri::XML(xml)

   #calculates at what distances on the trip pitstops should be placed

    total_trip_distance = @distance_in_m
    pitstop_interval = total_trip_distance / number_of_pitstops
    pitstop_distance = [pitstop_interval]

    i = pitstop_distance;
      while i.length <= (days - 2)
        i << (pitstop_interval += pitstop_interval)
      end

  #iterates over XML file, and extracts distance for each step,
  #which is accumulated until each pitstop is reached.
  #when pitstops are reached. latitude and longitude are fetched for the latest step.
  #coordinates for each pitstop is pushed into the step_array

    totalmeters = 0
    step_array = []
    j = 0
 #   array = []

    pitstop = pitstop_distance[j];

    @doc.root.xpath("//step").each do |child|
      break if j == pitstop_distance.count
      totalmeters += child.xpath('distance//value').text.to_i
  #    array << child.xpath('distance//value').text.to_i
      if totalmeters > pitstop
        step_array << [child.xpath('start_location//lat').text.to_f, child.xpath('start_location//lng').text.to_f]
        j += 1
        pitstop = pitstop_distance[j]
      end
    end

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
    Pitstop.pitstops_create_rest(@trip)
    Pitstop.pitstops_create_last(end_address, @trip)


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
end
