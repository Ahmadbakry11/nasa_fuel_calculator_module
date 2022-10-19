# frozen_string_literal: true

# Receives a tuple of mission type (:land) or (:launch).
# Calculates the required fuel to consume for each route.
# Returns that back the the FlightProgram instance.
class Mission
  MISSION_TYPES = %i[land launch]

  FACTOR = { land: 33, launch: 42 }

  attr_reader :type, :gravity
  attr_accessor :mission_fuel_mass

  def initialize(route)
    @type = route[0]
    @gravity = route[1]
    @mission_fuel_mass = 0
  end

  def opposite(type)
    key = FACTOR[:land] ^ FACTOR[:launch]
    key ^ FACTOR[type]
  end

  def fuel_consumption(mass)
    accumulate_fuel_mass(mass)
    mission_fuel_mass
  end

  def accumulate_fuel_mass(mass)
    return if mass <= 0

    mass = (mass * gravity * FACTOR[type].fdiv(1000) - opposite(type)).floor
    @mission_fuel_mass += mass if mass.positive?
    accumulate_fuel_mass(mass)
  end
end
