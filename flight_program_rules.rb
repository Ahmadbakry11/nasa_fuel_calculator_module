# frozen_string_literal: true

module FlightProgramRules
  VALID_MISSONS = [:launch, :land]
  VALID_GRAVITIES = [9.807, 1.62, 3.711]

  ship_mass_must_exist = Proc.new do |args|
    result = args[:ship_mass] != nil
    args[:errors] << 'ERROR: Ship mass can not be blank' unless result
    result
  end

  route_must_exist = Proc.new do |args|
    result = args[:route] != nil
    args[:errors] << 'ERROR: Route can not be blank' unless result
    result
  end

  ship_mass_must_be_positive_number = Proc.new do |args|
    ship_mass = args[:ship_mass]
    result = ship_mass.kind_of?(Numeric) && ship_mass > 0
    args[:errors] << ('ERROR: Ship mass must be a positive number') unless result
    result
  end

  route_must_be_an_array = Proc.new do |args|
    result = args[:route].kind_of?(Array) && args[:route].any?
    args[:errors] << ('ERROR: Route must be an Array of two element tuples') unless result
    result
  end

  route_must_contain_two_element_tuples_only = Proc.new do |args|
    result = valid_route_tuples?(args)
    args[:errors] << ('ERROR: Route missions must be a two elements array') unless result
    result
  end

  route_tuples_must_contain_mision_and_gravity = Proc.new do |args|
    result = tuples_have_valid_missions_and_gravities?(args)
    args[:errors] << ('ERROR: Route tuples must have right mission and right gravity') unless result
    result
  end

  route_must_start_with_launch_end_with_land = Proc.new do |args|
    result = args[:route].first[0] == :launch && args[:route].last[0] == :land
    args[:errors] << ('ERROR: Route must start with a launch mission and end with land') unless result
    result
  end

  route_must_be_consistent = Proc.new do |args|
    result = consistent_missions_types?(args) && consistent_gravities?(args)
    args[:errors] << ('ERROR: The whole route path is not consistent') unless result
    result
  end

  RULES = [
    ship_mass_must_exist,
    route_must_exist,
    ship_mass_must_be_positive_number,
    route_must_be_an_array,
    route_must_contain_two_element_tuples_only,
    route_tuples_must_contain_mision_and_gravity,
    route_must_start_with_launch_end_with_land,
    route_must_be_consistent
  ]

  private

  def self.consistent_missions_types?(args)
    missions = args[:route].map(&:first)

    missions.each_with_index do |m, i|
      return false if i.even? && m == :land
      return false if i.odd? && m == :launch
    end
    true
  end

  def self.consistent_gravities?(args)
    gravities = args[:route].map(&:last)

    gravities.rotate(-1).each_slice(2) do |pair|
      return false unless pair[0] == pair[1]
    end
    true
  end

  def self.tuples_have_valid_missions_and_gravities?(args)
    args[:route].each do |tuple|
      result = VALID_MISSONS.include?(tuple[0]) && VALID_GRAVITIES.include?(tuple[1])
      return false unless result
    end
    true
  end

  def self.valid_route_tuples?(args)
    args[:route].each do |tuple|
      result = tuple.kind_of?(Array) && tuple.size == 2
      return false unless result
    end
    true
  end
end