require 'rails_helper'

RSpec.describe RoadtripFacade, type: :facade do
  
  context 'class methods', :vcr do
    describe '::get_roadtrip' do
      context 'valid route response' do
        let!(:roadtrip) { RoadtripFacade.get_roadtrip('denver,co', 'estespark,co', 'm') }
        
        it 'returns a Roadtrip object' do
          expect(roadtrip).to be_a(Roadtrip)
        end
        
        it 'returns a road trip with correct start and end cities' do
          expect(roadtrip.start_city).to eq('Denver, CO')
          expect(roadtrip.end_city).to eq('Estes Park, CO')
        end
        
        it 'returns a road trip with correct travel time' do
          expect(roadtrip.travel_time).to eq('1 hour(s), 22 min(s)')
        end
        
        it 'returns a road trip with eta rounded up, weather conditions' do
          expected_weather = { temperature: 27.45, conditions: 'broken clouds' }
          expect(roadtrip.weather_at_eta).to eq(expected_weather)
        end
      end
      
      context 'invalid route response' do
        let!(:roadtrip) { RoadtripFacade.get_roadtrip('denver,co', 'london,uk', 'm') }
        
        it 'returns a Roadtrip object' do
          expect(roadtrip).to be_a(Roadtrip)
        end
        
        it 'returns a road trip with unformatted start and end cities' do
          expect(roadtrip.start_city).to eq('denver,co')
          expect(roadtrip.end_city).to eq('london,uk')
        end

        it 'returns a road trip with impossible travel time' do
          expect(roadtrip.travel_time).to eq('impossible')
        end
        
        it 'returns a road trip with empty weather at eta' do
          expect(roadtrip.weather_at_eta).to be_empty
        end
      end
    end
  end
end
