class TripMembersController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    @trip = Trip.find(params[:trip_id])

    @user = User.find_by_email(params[:trip_member][:user])
    @trip_member = TripMember.create(trip: @trip, user: @user)

    if @trip_member
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end

  def destroy
  end

  private

  def trip_member_params
    params.require(:trip_member).permit(:trip_member, :user.email, :trip)
  end
end
