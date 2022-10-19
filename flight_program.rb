# frozen_string_literal: true

require_relative 'mission'

class FlightProgram
  attr_reader :route
  attr_accessor :total_mass, :missions, :total_fuel_mass, :errors

  def initialize(args)
    @args = args
    @errors = []
    return unless valid?

    @total_mass = args[:ship_mass]
    @route = args[:route]

    @missions = []
    @total_fuel_mass = 0

    set_flight_missions
  end

  def method_missing( method_name, args = @args )
    flight_input = FlightProgramInput.new(args)
    @errors = flight_input.errors
    flight_input.send(method_name)
  end

  def calculate_fuel_mass
    missions.each do |mission|
      mission_fuel_consumption = mission.fuel_consumption(@total_mass)
      @total_fuel_mass += mission_fuel_consumption
      @total_mass += mission_fuel_consumption
    end
    total_fuel_mass
  end

  private

  def set_flight_missions
    route.reverse.each do |r|
      missions << Mission.new(r)
    end
  end
end
