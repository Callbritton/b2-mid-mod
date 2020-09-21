class FlightPassengersController < ApplicationController

  def destroy

    passenger = FlightPassenger.where(passenger_id: params[:id])
    passenger.first.delete
    redirect_to "/flights"
  end
end
