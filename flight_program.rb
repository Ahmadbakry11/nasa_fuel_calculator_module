# frozen_string_literal: true

require_relative 'flight_program_input'
require_relative 'landing_mission'
require_relative 'launching_mission'
require_relative 'route'

class FlightProgram
  attr_accessor :total_mass, :route, :missions, :total_fuel_mass, :errors

  def initialize(args)
    args = defaults.merge(args)
    @errors = args[:errors]
    return unless valid?(args)

    @total_mass = args[:ship_mass]
    @route = args[:route]
    @missions = args[:missions]
    @total_fuel_mass = args[:total_fuel_mass]

    set_flight_routes
    set_flight_missions
  end

  def method_missing( method_name, args )
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
    @total_fuel_mass
  end

  private

  def defaults
    { 
      errors: [], 
      missions: [],
      total_fuel_mass: 0 
    }
  end

  def set_flight_routes
    @route.each { |r| Route.new(r) }
  end

  def set_flight_missions
    Route.all.reverse.each do |route|
      mission = LaunchingMission.new(route.gravity) if route.mission_type == :launch
      mission = LandingMission.new(route.gravity) if route.mission_type == :land
      missions << mission
    end
  end
end

