# frozen_string_literal: true

class LaunchingMission
  attr_accessor :mission_fuel_mass

  def initialize(gravity)
    @mission_fuel_mass = 0
    @gravity = gravity
  end

  def fuel_consumption(mass)
    launch_ship(mass, @gravity)
    @mission_fuel_mass
  end

  def launch_ship(mass, gravity)
    return if mass <= 0
    fuel_mass = (mass * gravity * 0.042 - 33).floor
    @mission_fuel_mass += fuel_mass if fuel_mass > 0
    launch_ship(fuel_mass, gravity)
  end
end

