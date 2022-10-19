# frozen_string_literal: true

module ErrorMessages
  MESSAGES = {
    syntax_error: 'ERROR: Syntax or Name error',
    args_type: 'ERROR: args must be a hash',
    blank_ship_mass: 'ERROR: Ship mass can not be blank',
    blank_route: 'ERROR: Route can not be blank',
    ship_mass_type: 'ERROR: Ship mass must be a positive number',
    route_type: 'ERROR: Route must be an Array with tuples',
    route_missions_type: 'ERROR: Route missions must be a two elements array or tuple',
    route_missions: 'ERROR: Each route mission must have correct values for both mission type and gravity',
    route_path: 'ERROR: The whole fligt route must start with a launch mission and end with a land mission',
    consistent_route: 'ERROR: The whole route path is not consistent'
  }
end
