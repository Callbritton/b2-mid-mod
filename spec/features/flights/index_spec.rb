require 'rails_helper'

RSpec.describe "When I visit a flight's index page," do
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
    FlightPassenger.create(flight_id: @flight1.id, passenger_id: @passenger_2.id)
    FlightPassenger.create(flight_id: @flight2.id, passenger_id: @passenger_3.id)
  end

  it "I see all flight numbers and the names of all that flights passengers" do
    visit "/flights"

    expect(page).to have_content(@flight1.number)
    expect(page).to have_content(@flight2.number)
    expect(page).to have_content(@flight3.number)
    expect(page).to have_content(@flight4.number)
save_and_open_page
    within ".flight-#{@flight1.id}" do
      expect(page).to have_content(@passenger_1.name)
      expect(page).to have_content(@passenger_2.name)
      expect(page).to_not have_content(@passenger_3.name)
    end
  end
end
