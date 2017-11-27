class PitstopsController < ApplicationController
  def show
  end

  def new
    @pitstop = Pitstop.find(params[:id])
  end

  def create
  end


  def edit
    @pitstop = Pitstop.find(params[:id])

  end

  def update
    #@trip = Trip.find(params[:trip_id])
    #address = params[:address]
    #stage = Stage.find(params[:stage_id])
    #@pitstop = stage.end_point.address
    stage = Stage.find(params[:stage_id])
    pitstop = stage.end_point
    pitstop.update(pitstop_params)
    redirect_to trip_path(stage.trip)


    end

  def destroy
  end

  private

  def pitstop_params
    params.require(:pitstop).permit(:name, :address, :latitude, :longitude, :price, :rating, :start_stage_id, :end_stage_id)
  end
end

