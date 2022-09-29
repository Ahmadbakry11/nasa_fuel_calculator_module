# frozen_string_literal: true

class Route
  @routes = []

  class << self
    attr_accessor :routes

    def all 
      @routes
    end
  end

  attr_accessor :mission_type, :gravity

  def initialize(route)
    @mission_type = route[0]
    @gravity = route[1]
    update_routes
  end

  def update_routes
    Route.all << self
  end
end