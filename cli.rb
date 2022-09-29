#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'flight_program'
require_relative 'flight_program_input'
require 'highline'
require 'pry'

module FlightFuelCalculator
  def self.calculate(args)
    flight_program = FlightProgram.new(args)
    print_errors(flight_program) && return if flight_program.errors.any?
    puts "#{flight_program.calculate_fuel_mass} kg of fuel required for the whole journey"
  rescue ArgumentError
    puts 'Input argument must be of a Hash type'
  end

  def self.print_errors(flight_program)
    flight_program.errors.each { |e| puts e}
  end
end

args = {}
cli = HighLine.new
begin
  ship_mass = cli.ask('Enter the weight of the equipment?  ')
  args[:ship_mass] = eval(ship_mass)
  route = cli.ask('Enter the whole flight route. Example: [[:mission1, gravity1], [:mission2, gravity2]]?  ') 
  args[:route] = eval(route)
rescue Exception
  puts 'SynatxError: Invalid Arguments supplied'
end

FlightFuelCalculator.calculate(args)
