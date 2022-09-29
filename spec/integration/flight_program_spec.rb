require_relative '../../flight_program'

RSpec.describe FlightProgram do
  let(:args) { { ship_mass: 28801, route: [[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 9.807]] } }
  let(:flight_program) { FlightProgram.new(args) }
  let(:missions) { flight_program.missions }
  
  context 'when flight program input is correct' do
    before(:each) { Route.all.clear }

    it 'creates a valid flight program instance' do
      expect(flight_program.valid?(args)).to be_truthy
      expect(flight_program.errors.size).to eq(0)
    end

    it 'creates Routes objects the same as the provides route tuples' do
      expect{ FlightProgram.new(args) }.to change { Route.all.size }.from(0).to(4)
    end

    it 'creates flight missions instances the same as the provided' do
      expect(missions.reverse.first).to be_a_kind_of(LaunchingMission)
      expect(missions.reverse.last).to be_a_kind_of(LandingMission)
      expect(missions.size).to eq(flight_program.route.size)
    end

    it 'calculates the required fuel mass for the whole flight' do
      expect(flight_program.calculate_fuel_mass).to eq(51898)
    end
  end

  context 'when flight program input is invalid' do
    let(:args) { { ship_mass: -900, route: [] } }

    it 'creates an invalid flight program instance' do
      expect(flight_program.valid?(args)).to be_falsey
      expect(flight_program.errors).not_to be_empty
    end
  end
end