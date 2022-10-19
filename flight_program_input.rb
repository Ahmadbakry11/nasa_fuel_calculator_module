# frozen_string_literal: true

require 'pry'
require_relative './flight_program_rules'

class FlightProgramInput
  include FlightProgramRules

  attr_accessor :args, :errors

  def initialize(args)
    @args = args
    @errors = []
  end

  def valid?
    apply_flight_program_rules
    errors.empty?
  end

  def apply_flight_program_rules
    RULES.each do |rule|
      result = rule.call(args, errors)
      break unless result
    end
  end
end
