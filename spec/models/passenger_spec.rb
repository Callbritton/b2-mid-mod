require 'rails_helper'

RSpec.describe Passenger do
  describe 'relationships' do
    it {should have_many :flight_passengers}
    it {should have_many(:flights).through(:flight_passengers)}
  end

  describe "Instance Methods" do
    it ".flight_count" do
      airline1 = Airline.create(name: "Virgin Air")

      flight1 = airline1.flights.create(number: 1727)
      flight2 = airline1.flights.create(number: 3345)
      flight3 = airline1.flights.create(number: 1123)
      flight4 = airline1.flights.create(number: 5436)

      passenger_1 = Passenger.create(name: "Jim Bob", age: 22)
      passenger_2 = Passenger.create(name: "Billy Bob", age: 17)
      passenger_3 = Passenger.create(name: "Charles Bob", age: 33)

      FlightPassenger.create(flight_id: flight1.id, passenger_id: passenger_1.id)
      FlightPassenger.create(flight_id: flight2.id, passenger_id: passenger_1.id)
      FlightPassenger.create(flight_id: flight3.id, passenger_id: passenger_1.id)
      FlightPassenger.create(flight_id: flight1.id, passenger_id: passenger_2.id)
      FlightPassenger.create(flight_id: flight2.id, passenger_id: passenger_2.id)
      FlightPassenger.create(flight_id: flight4.id, passenger_id: passenger_3.id)

      expect(passenger_1.flight_count).to eq(3)
    end
  end
end
