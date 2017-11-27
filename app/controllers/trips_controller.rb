class TripsController < ApplicationController

  def index
    @trip = Trip.first
    @average_stage_length = []
  end

  def show
    @trip = Trip.find(params[:id])
    @stages = @trip.stages
  end

  def new
  end

  def create

    ####### 1 INSTANTIATING A NEW TRIP
    @trip = Trip.new

    ####### 3 CREATING STAGES
    start_date = params[:start_date]
    end_date = params[:end_date]
    stage_no = 1
    @trip.set_stages(stage_no, start_date, end_date) # From Trip model
    
    ####### 4 CREATING PITSTOPS
    start_address = params[:start]
    end_address = params[:finish]
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
