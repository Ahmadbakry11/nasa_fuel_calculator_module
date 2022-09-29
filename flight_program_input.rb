# frozen_string_literal: true

require 'pry'
require_relative './flight_program_rules'

class FlightProgramInput
  include FlightProgramRules

  attr_accessor :args, :errors

  def initialize(args)
    raise ArgumentError unless args.kind_of?(Hash)
    @args = defaults.merge(args)
    @errors = @args[:errors]
  end

  def valid?
    apply_flight_program_rules(args)
    @errors.empty?
  end

  def apply_flight_program_rules(args)
    RULES.each do |rule|
      result = rule.call(args)
      break unless result
    end
  end

  def defaults
    { errors: [] }
  end
end
