require_relative '../../launching_mission'

RSpec.describe LaunchingMission do
  let(:mass) { 28801 }
  let(:gravity) { 9.807 }
  let(:launching_mission) { LaunchingMission.new(gravity) }

  context "When the mass to be launched is greater than zero" do
    let(:expected) { 19772 }

    it 'returns the required fuel mass for launching' do
      expect(launching_mission.fuel_consumption(mass)).to eq(expected)
    end
  end

  context "When the mass to be launched is less than or equal to zero" do
    let(:mass) { -900 }
    let(:expected) { 0 }

    it 'returns zero kg of fuel consumption' do
      expect(launching_mission.fuel_consumption(mass)).to eq(expected)
    end
  end
end


