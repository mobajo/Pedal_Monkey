class PitstopsController < ApplicationController
  def show
  end

  def new
  end

  def create
  end

  def update
    @pitstop = Pitstop.find(params[:id])
  end

  def edit
    @user = current_user
    @pitstop = Pitstop.find(params[:id])
  end

  def destroy
  end
end

