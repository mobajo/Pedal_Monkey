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
    @pitstop = Pitstop.find(params[:id])
    raise
  end
  def destroy
  end

  private

  def pitstop_params
    params.require(:pitstop).permit(:name, :address, :latitude, :longitude, :price, :rating, :start_stage_id, :end_stage_id)
  end
end

