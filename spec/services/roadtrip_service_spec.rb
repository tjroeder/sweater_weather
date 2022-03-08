require 'rails_helper'

RSpec.describe RoadtripService, type: :service do
  context 'class methods', :vcr do
    describe '::get_route' do
      it 'returns a response hash' do
        route = RoadtripService.get_route('denver,co', 'pueblo,co', 'm')

        expect(route).to be_a(Hash)
      end
    end
  end
end
