require_relative '../../flight_program_input'

RSpec.describe FlightProgramInput do
  let(:args) { {} }
  let(:subject) { FlightProgramInput.new(args) }

  context 'when the supplied input for the flight program is invalid' do
    context 'when the input is not of type Hash' do
      let(:args) { "It is a bad input"}

      it 'raises an ArgumentError' do
        expect { subject }.to raise_error(ArgumentError) 
      end
    end

    context 'when the input is an empty Hash' do
      it 'returns an invalid input with error' do
        expect(subject.valid?).to be_falsey

        expect(subject.errors).to contain_exactly(
          a_string_matching('Ship mass can not be blank')
        )
      end
    end

    context 'when the route key is not provided' do
      let(:args) { { ship_mass: 28801 } }

      it 'returns an invalid input with error' do
        expect(subject.valid?).to be_falsey

        expect(subject.errors).to contain_exactly(
          a_string_matching('ERROR: Route can not be blank')
        )
      end
    end

    context 'when the ship_mass key is not provided' do
      let(:args) { { route: [[:launch, 9.807], [:land, 1.62]] } }

      it 'returns an invalid input with error' do
        expect(subject.valid?).to be_falsey

        expect(subject.errors).to contain_exactly(
          a_string_matching('ERROR: Ship mass can not be blank')
        )
      end
    end

    context 'when the ship_mass is negative or zero' do
      let(:args) { { ship_mass: -900, route: [[:launch, 9.807], [:land, 1.62]] } }

      it 'returns an invalid input with error' do
        expect(subject.valid?).to be_falsey

        expect(subject.errors).to contain_exactly(
          a_string_matching('ERROR: Ship mass must be a positive number')
        )
      end
    end

    context 'when the route is not an array or an empty array' do
      let(:args) { { ship_mass: 28801, route: 'Hi' } }

      it 'returns an invalid input with error' do
        expect(subject.valid?).to be_falsey

        expect(subject.errors).to contain_exactly(
          a_string_matching('ERROR: Route must be an Array of two element tuples')
        )
      end
    end

    context 'when any of the route tuples contains a mission or a gravity out of the concern of Nasa Program' do
      let(:args) { { ship_mass: 28801, route: [[:jump, 6666666], [:launch, 1.62], [:land, 1.62]] } }

      it 'returns an invalid input with error' do
        expect(subject.valid?).to be_falsey

        expect(subject.errors).to contain_exactly(
          a_string_matching('ERROR: Route tuples must have right mission and right gravity')
        )
      end
    end

    context 'when the whole route is not starting with launch and ending with land' do
      let(:args) { { ship_mass: 28801, route: [[:land, 9.807], [:land, 1.62], [:launch, 1.62], [:launch, 9.807]] } }

      it 'returns an invalid input with error' do
        expect(subject.valid?).to be_falsey

        expect(subject.errors).to contain_exactly(
          a_string_matching('ERROR: Route must start with a launch mission and end with land')
        )
      end
    end

    context 'when the whole route is not consistent' do
      context 'non consistent gravities, i.e. 9.807 --> 1.62 --> 3.711' do
        let(:args) { { ship_mass: 28801, route: [[:launch, 9.807], [:land, 1.62], [:launch, 3.711], [:land, 9.807]] } }

        it 'returns an invalid input with error' do
          expect(subject.valid?).to be_falsey
  
          expect(subject.errors).to contain_exactly(
            a_string_matching('ERROR: The whole route path is not consistent')
          )
        end
      end

      context 'non consistent missions, i.e. launch --> land --> land' do
        let(:args) { { ship_mass: 28801, route: [[:launch, 9.807], [:land, 1.62], [:land, 1.62], [:land, 9.807]] } }

        it 'returns an invalid input with error' do
          expect(subject.valid?).to be_falsey
  
          expect(subject.errors).to contain_exactly(
            a_string_matching('ERROR: The whole route path is not consistent')
          )
        end
      end
    end
  end

  context 'when the supplied input for the flight program is valid' do
  end
end