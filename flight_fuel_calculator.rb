# frozen_string_literal: true

require_relative 'flight_program'

# Receives the FlightProgram instance and the FlightProgramValidator instance.
# Delegates the validation process of the FlightProgram instance to the
# FlightProgramValidator instance.
# Calculates the FlightProgram fuel consumption in case of valid args.
module FlightFuelCalculator
  class << self
    def calculate(flight_program)
      unless flight_program.valid?
        print_errors(flight_program)
        return
      end

      print_result(flight_program.calculate_fuel_mass)
    end

    def print_errors(flight_program)
      flight_program.errors.each { |e| puts e.red }
    end

    def print_result(fuel_mass)
      puts "#{fuel_mass} kg of fuel required for the whole flight\n".green
    end
  end
end
