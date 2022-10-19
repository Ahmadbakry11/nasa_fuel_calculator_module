# frozen_string_literal: true

require_relative 'error_messages'

module FlightProgramRules
  include ErrorMessages

  VALID_MISSONS = %i[launch land]
  VALID_GRAVITIES = [9.807, 1.62, 3.711]

  args_must_be_a_hash = Proc.new do |args, errors|
    result = args.kind_of?(Hash)
    errors << MESSAGES[:args_type] unless result
    result
  end

  ship_mass_must_exist = Proc.new do |args, errors|
    result = args[:ship_mass] != nil
    errors << MESSAGES[:blank_ship_mass] unless result
    result
  end

  route_must_exist = Proc.new do |args, errors|
    result = args[:route] != nil
    errors << MESSAGES[:blank_route] unless result
    result
  end

  ship_mass_must_be_positive_number = Proc.new do |args, errors|
    ship_mass = args[:ship_mass]
    result = ship_mass.kind_of?(Numeric) && ship_mass > 0
    errors << MESSAGES[:ship_mass_type] unless result
    result
  end

  route_must_be_an_array = Proc.new do |args, errors|
    result = args[:route].kind_of?(Array) && args[:route].any?
    errors << MESSAGES[:route_type] unless result
    result
  end

  route_must_contain_two_element_tuples_only = Proc.new do |args, errors|
    result = valid_route_tuples?(args)
    errors << MESSAGES[:route_missions_type] unless result
    result
  end

  route_tuples_must_contain_mission_and_gravity = Proc.new do |args, errors|
    result = tuples_have_valid_missions_and_gravities?(args)
    errors << MESSAGES[:route_missions] unless result
    result
  end

  route_must_start_with_launch_end_with_land = Proc.new do |args, errors|
    result = args[:route].first[0] == :launch && args[:route].last[0] == :land
    errors << MESSAGES[:route_path] unless result
    result
  end

  route_must_be_consistent = Proc.new do |args, errors|
    result = consistent_missions_types?(args) && consistent_gravities?(args)
    errors << MESSAGES[:consistent_route] unless result
    result
  end

  RULES = [
    args_must_be_a_hash,
    ship_mass_must_exist,
    route_must_exist,
    ship_mass_must_be_positive_number,
    route_must_be_an_array,
    route_must_contain_two_element_tuples_only,
    route_tuples_must_contain_mission_and_gravity,
    route_must_start_with_launch_end_with_land,
    route_must_be_consistent
  ]

  class << self
    def consistent_missions_types?(args)
      missions = args[:route].map(&:first)

      missions.each_with_index do |m, i|
        return false if i.even? && m == :land
        return false if i.odd? && m == :launch
      end
      true
    end

    def consistent_gravities?(args)
      gravities = args[:route].map(&:last)

      gravities.rotate(-1).each_slice(2) do |pair|
        return false unless pair[0] == pair[1]
      end
      true
    end

    def tuples_have_valid_missions_and_gravities?(args)
      args[:route].each do |tuple|
        result = VALID_MISSONS.include?(tuple[0]) && VALID_GRAVITIES.include?(tuple[1])
        return false unless result
      end
      true
    end

    def valid_route_tuples?(args)
      args[:route].each do |tuple|
        result = tuple.kind_of?(Array) && tuple.size == 2
        return false unless result
      end
      true
    end
  end
end