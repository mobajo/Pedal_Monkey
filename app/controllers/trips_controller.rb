class TripsController < ApplicationController

  def index
    @trip = Trip.first
  end

  def show
    @trip = Trip.find(params[:id])
    @stages = @trip.stages
    @trip_member = TripMember.new()
  end

  def new
  end

  def create

    start_address = params[:start]
    end_address = params[:finish]
    start_date = params[:start_date]
    end_date = params[:end_date]

    directions = GoogleDirections.new(start_address, end_address)
    drive_time_in_minutes = directions.drive_time_in_minutes
    distance_in_m = directions.distance.to_i
    xml = directions.xml
    @doc = Nokogiri::XML(xml)

    numberOfWaypoints = (end_date.to_date - start_date.to_date).to_i
    totalTripDistance = distance_in_m
    wayPointInterval = totalTripDistance / numberOfWaypoints
    wayPointsDistance = [wayPointInterval]

    i = wayPointsDistance;
      while i.length <= (numberOfWaypoints - 2)
        i << (wayPointInterval += wayPointInterval)
      end


    totalmeters = 0
    step_array = []
    j = 0
 #   array = []

    wayPoint = wayPointsDistance[j];

    @doc.root.xpath("//step").each do |child|
      break if j == wayPointsDistance.count
      totalmeters += child.xpath('distance//value').text.to_i
  #    array << child.xpath('distance//value').text.to_i
      if totalmeters > wayPoint
        step_array << [child.xpath('start_location//lat').text.to_f, child.xpath('start_location//lng').text.to_f]
        j += 1
        wayPoint = wayPointsDistance[j]
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
