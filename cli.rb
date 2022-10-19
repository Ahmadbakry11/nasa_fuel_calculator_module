#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'flight_fuel_calculator'
require_relative 'flight_program_input'
require_relative 'flight_program'
require_relative 'error_messages'
require 'highline'
require 'colorize'
require 'pry'

module Cli
  include ErrorMessages

  INSTRUCTIONS = <<-END_HEREDOC
    Please provide the correct inputs for the program to calculate the fuel mass\n
    Ship Mass or wight: must be a valid positive number in kg \n
    Flight Route: Must be an array of two element tuples like [[:mission1, gravity1], [:mission2, gravity2]]\n
    Valid allowed missions: Only allowed :land or :launch\n
    Valid allowed gravities: Only allowed 9.807, 1.62, 3.711 for planets Earth, Moon and Mars respectively\n

    Press Enter to continue\n
  END_HEREDOC

  SHIP_MASS_QUESTION = "Enter the weight of the equipment ? \n|>  ".yellow
  ROUTE_QUESTION = "Enter the whole flight route ? \n|>  ".yellow

  @args = {}
  @cli = HighLine.new

  def self.receive_inputs
    @cli.ask(INSTRUCTIONS)

    ship_mass = @cli.ask(SHIP_MASS_QUESTION)
    @args[:ship_mass] = instance_eval(ship_mass)
    puts "\n"

    route = @cli.ask(ROUTE_QUESTION)
    @args[:route] = instance_eval(route)
    puts "\n"

    start_fuel_calculation_process
  rescue NameError, SyntaxError
    puts MESSAGE[:syntax_error].red
  end

  def self.start_fuel_calculation_process
    flight_program = FlightProgram.new(@args)
    FlightFuelCalculator.calculate(flight_program)
  end
end

Cli.receive_inputs
