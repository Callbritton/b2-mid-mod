require 'rails_helper'

RSpec.describe "When I visit a passenger's index page," do
  before :each do
    @airline1 = Airline.create(name: "Virgin Air")

    @flight1 = @airline1.flights.create(number: 1727)
    @flight2 = @airline1.flights.create(number: 3345)
    @flight3 = @airline1.flights.create(number: 1123)
    @flight4 = @airline1.flights.create(number: 5436)

    @passenger_1 = Passenger.create(name: "Jim Bob", age: 22)
    @passenger_2 = Passenger.create(name: "Billy Bob", age: 17)
    @passenger_3 = Passenger.create(name: "Charles Bob", age: 33)

    FlightPassenger.create(flight_id: @flight1.id, passenger_id: @passenger_1.id)
    FlightPassenger.create(flight_id: @flight2.id, passenger_id: @passenger_1.id)
    FlightPassenger.create(flight_id: @flight3.id, passenger_id: @passenger_1.id)
    FlightPassenger.create(flight_id: @flight1.id, passenger_id: @passenger_2.id)
    FlightPassenger.create(flight_id: @flight2.id, passenger_id: @passenger_2.id)
    FlightPassenger.create(flight_id: @flight4.id, passenger_id: @passenger_3.id)
  end

  it "I see names of all passengers and the nunber of flights that passenger has" do
    visit "/passengers"

    expect(page).to have_content(@passenger_1.name)
    expect(page).to have_content(@passenger_2.name)
    expect(page).to have_content(@passenger_3.name)

    within ".passenger-#{@passenger_1.id}" do
      expect(page).to have_content("Flights: 3")
    end

    within ".passenger-#{@passenger_2.id}" do
      expect(page).to have_content("Flights: 2")
    end

    within ".passenger-#{@passenger_3.id}" do
      expect(page).to have_content("Flights: 1")
    end
  end
end
