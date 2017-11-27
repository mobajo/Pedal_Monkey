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

    ####### 2 CREATING STAGES
    stages_create

    ####### 3 CREATING PITSTOPS
    pitstops_create_first
    pitstops_create_rest
    pitstop_create_last
    # SAVE AND RENDER THE TRIP IF NO ERRORS
    @trip.save
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

  def stages_create
    # 2.1 first stage
    start_date = params[:start_date]
    stage_no = 1
    @first_stage = Stage.new(trip: @trip, stage_no: stage_no, stage_date: start_date)
    @first_stage.save

    # 2.3 Iteration for creating remaining stages minus the last one
    end_date = params[:end_date]
    days = (end_date.to_date - start_date.to_date).to_i # WHAT IF TRIP IS ONLY ONE DAY
    stage_date = params[:start_date].to_date

    days.times do
      stage = Stage.new(trip: @trip)
      stage_no += 1
      stage.stage_no = stage_no
      stage_date += 1
      stage.stage_date = stage_date
      stage.save
    end
  end

  def pitstops_create_first
    # 3.1 Creating first pitstop with FROM value from form / assign to first stage
    first_pitstop = Pitstop.new
    first_pitstop.start_stage = @first_stage
    first_pitstop.address = params[:start]
    first_pitstop.save
  end

  def pitstops_create_rest
    # 3.2 Iteration for creating remaining pitstops minus the last one
    pitstops = @trip.stages.count # UNLESS TRIP IS ONLY ONE DAY?
    assign_counter = 1
    assign_stage = @trip.find_stage(assign_counter)

    # Tag pitstop antal - 2
    # Lav en ny pitstop
    # Den slutter ved stage x og starter stage x + 1

    (pitstops - 1).times do
      pitstop = Pitstop.new
      pitstop.end_stage = assign_stage
      assign_counter += 1
      assign_stage = @trip.find_stage(assign_counter)
      pitstop.start_stage = assign_stage
      pitstop.save
    end
  end

  def pitstop_create_last
    # 3.3 Creating last pitstop
    @pitstop = Pitstop.new
    @pitstop.end_stage = @trip.find_stage(@trip.stages.count)
    @pitstop.address = params[:finish]
    @pitstop.save
  end

end
