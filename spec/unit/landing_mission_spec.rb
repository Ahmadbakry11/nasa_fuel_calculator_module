require_relative '../../landing_mission'

RSpec.describe LandingMission do
  let!(:mass) { 28801 }
  let!(:gravity) { 9.807 }
  let(:landing_mission) { LandingMission.new(gravity) }

  context "When the mass to be landed is greater than zero" do
    let(:expected) { 13447 }

    it 'returns the required fuel mas for landing' do
      expect(landing_mission.fuel_consumption(mass)).to eq(expected)
    end
  end
  
  context "When the mass to be landed is less than or equal to zero" do
    let(:mass) { -900 }
    let(:expected) { 0 }

    it 'returns zero kg of fuel consumption' do
      expect(landing_mission.fuel_consumption(mass)).to eq(expected)
    end
  end
end