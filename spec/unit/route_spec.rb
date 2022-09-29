require_relative '../../route'

RSpec.describe Route do
  let(:route_input) { [:launch, 9.807] }
  let(:route) { Route.new(route_input) }
  before(:all) { Route.all.clear }

  describe "a Route instance receives an array of two element tuple" do
    it 'creates a route instance with mission and gravity' do
      expect(route.mission_type).to eq(:launch)
      expect(route.gravity).to eq(9.807)
      expect(Route.all.size).to eq(1)
      expect { Route.new([:land, 1.62]) }.to change { Route.all.size }.from(1).to(2)
    end
  end
end


