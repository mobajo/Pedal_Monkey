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
    trip = Trip.find(params[:trip_id])
    pitstop = Pitstop.find(params[:id])
    pitstop.update(pitstop_params)
    redirect_to trip_path(trip )
  end

  def destroy
  end

  private

  def pitstop_params
    params.require(:pitstop).permit(:name, :address, :latitude, :longitude, :price, :rating, :start_stage_id, :end_stage_id)
  end
end

