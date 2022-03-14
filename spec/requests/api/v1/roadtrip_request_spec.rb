require 'rails_helper'

RSpec.describe 'Roadtrip Request API', :vcr, type: :request do
  let!(:headers) { 
                   { 
                     'CONTENT_TYPE' => 'application/json', 
                     'Accept' => 'application/json' 
                   } 
                 }

  context '#create action' do
    describe 'valid road trip request' do
      let!(:user) { create(:user, email: 'user@email.com', password: '12345678') }
      let!(:rt_params) { { origin: 'denver,co', destination: 'estespark,co', api_key: user.api_key } }
      before(:each) { post api_v1_road_trip_path, headers: headers, params: rt_params.to_json }

      it 'returns a successful status when given valid roadtrip route' do
        expect(response).to be_successful
      end
      
      it 'returns parsable json data response for roadtrip' do        
        expect(json_parse(response.body)).to be_a(Hash)
      end
      
      it 'returns correct response attribute fields' do
        hash = json_parse(response.body)
        attr = hash[:data][:attributes]

        expect(hash).to have_key(:data)
        expect(hash[:data]).to have_key(:id)
        expect(hash[:data][:id]).to eq(nil)

        expect(hash[:data]).to have_key(:type)
        expect(hash[:data][:type]).to eq('roadtrip')
        expect(hash[:data]).to have_key(:attributes)

        expect(attr).to have_key(:start_city)
        expect(attr[:start_city]).to be_a(String)
        expect(attr[:start_city]).to eq('Denver, CO')

        expect(attr).to have_key(:end_city)
        expect(attr[:end_city]).to be_a(String)
        expect(attr[:end_city]).to eq('Estes Park, CO')

        expect(attr).to have_key(:travel_time)
        expect(attr[:travel_time]).to be_a(String)
        expect(attr[:travel_time]).to eq('1 hour(s), 22 min(s)')

        expect(attr).to have_key(:weather_at_eta)
        expect(attr[:weather_at_eta]).to be_a(Hash)
        expect(attr[:weather_at_eta].count).to eq(2)

        expect(attr[:weather_at_eta]).to have_key(:temperature)
        expect(attr[:weather_at_eta][:temperature]).to be_a(Float)
        expect(attr[:weather_at_eta][:temperature]).to eq(23.81)

        expect(attr[:weather_at_eta]).to have_key(:conditions)
        expect(attr[:weather_at_eta][:conditions]).to be_a(String)
        expect(attr[:weather_at_eta][:conditions]).to eq('broken clouds')
      end
    end

    describe 'invalid roadtrip request' do
      it 'returns bad request status when given invalid roadtrip route' do
        user =create(:user, email: 'user@email.com', password: '12345678')
        rt_params = { origin: 'denver,co', destination: 'london,uk', api_key: user.api_key }
        post api_v1_road_trip_path, headers: headers, params: rt_params.to_json

        expect(response.status).to eq(200)
      end
      
      it 'returns bad request status when missing api key param' do
        user =create(:user, email: 'user@email.com', password: '12345678')
        rt_params = { origin: 'denver,co', destination: 'estespark,co' }
        post api_v1_road_trip_path, headers: headers, params: rt_params.to_json

        hash = json_parse(response.body)
        expected_error = {
          errors: [
            { 
              status: 401, 
              id: 'API Key', 
              title: 'Param is missing or the value is empty: api_key' 
            }
          ]
        }
        
        expect(response.status).to eq(400)
        expect(hash).to eq(expected_error)
      end

      it 'returns bad request status when api key param is blank' do
        user =create(:user, email: 'user@email.com', password: '12345678')
        rt_params = { origin: 'denver,co', destination: 'estespark,co', api_key: ''  }
        post api_v1_road_trip_path, headers: headers, params: rt_params.to_json
        
        expect(response.status).to eq(400)
      end
      
      it 'returns bad request status when missing origin param' do
        user =create(:user, email: 'user@email.com', password: '12345678')
        rt_params = { destination: 'estespark,co', api_key: user.api_key }
        post api_v1_road_trip_path, headers: headers, params: rt_params.to_json
        
        hash = json_parse(response.body)
        expected_error = {
          errors: [
            { 
              status: 400, 
              id: 'Origin', 
              title: 'Param is missing or the value is empty: origin' 
            }
          ]
        }
        
        expect(response.status).to eq(400)
        expect(hash).to eq(expected_error)
      end

      it 'returns bad request status when origin param is blank' do
        user =create(:user, email: 'user@email.com', password: '12345678')
        rt_params = { origin: '', destination: 'estespark,co', api_key: user.api_key }
        post api_v1_road_trip_path, headers: headers, params: rt_params.to_json
        
        expect(response.status).to eq(400)
      end
      
      it 'returns bad request status when missing destination param' do
        user =create(:user, email: 'user@email.com', password: '12345678')
        rt_params = { origin: 'denver,co', api_key: user.api_key }
        post api_v1_road_trip_path, headers: headers, params: rt_params.to_json

        hash = json_parse(response.body)
        expected_error = {
          errors: [
            { 
              status: 400, 
              id: 'Destination', 
              title: 'Param is missing or the value is empty: destination' 
            }
          ]
        }
        
        expect(response.status).to eq(400)
        expect(hash).to eq(expected_error)
      end

      it 'returns bad request status when destination param is blank' do
        user =create(:user, email: 'user@email.com', password: '12345678')
        rt_params = { origin: 'denver,co', destination: '', api_key: user.api_key }
        post api_v1_road_trip_path, headers: headers, params: rt_params.to_json
        
        expect(response.status).to eq(400)
      end

      it 'returns bad request when origin, and destination param is missing' do
        user =create(:user, email: 'user@email.com', password: '12345678')
        rt_params = { api_key: user.api_key }
        post api_v1_road_trip_path, headers: headers, params: rt_params.to_json

        hash = json_parse(response.body)
        expected_error = {
          errors: [
            { 
              status: 400, 
              id: 'Origin', 
              title: 'Param is missing or the value is empty: origin' 
            },
            { 
              status: 400, 
              id: 'Destination', 
              title: 'Param is missing or the value is empty: destination' 
            }
          ]
        }
        
        expect(response.status).to eq(400)
        expect(hash).to eq(expected_error)
      end

      it 'returns bad request when origin, and api key param is missing' do
        user =create(:user, email: 'user@email.com', password: '12345678')
        rt_params = { destination: 'estespark,co' }
        post api_v1_road_trip_path, headers: headers, params: rt_params.to_json

        hash = json_parse(response.body)
        expected_error = {
          errors: [
            { 
              status: 400, 
              id: 'Origin', 
              title: 'Param is missing or the value is empty: origin' 
            },
            { 
              status: 401, 
              id: 'API Key', 
              title: 'Param is missing or the value is empty: api_key' 
            }
          ]
        }
        
        expect(response.status).to eq(400)
        expect(hash).to eq(expected_error)
      end

      it 'returns bad request when destination, and api key param is missing' do
        user =create(:user, email: 'user@email.com', password: '12345678')
        rt_params = { origin: 'denver,co' }
        post api_v1_road_trip_path, headers: headers, params: rt_params.to_json

        hash = json_parse(response.body)
        expected_error = {
          errors: [
            { 
              status: 400, 
              id: 'Destination', 
              title: 'Param is missing or the value is empty: destination' 
            },
            { 
              status: 401, 
              id: 'API Key', 
              title: 'Param is missing or the value is empty: api_key' 
            }
          ]
        }
        
        expect(response.status).to eq(400)
        expect(hash).to eq(expected_error)
      end

      it 'returns bad request when origin, destination, and api key param is missing' do
        user =create(:user, email: 'user@email.com', password: '12345678')
        rt_params = { }
        post api_v1_road_trip_path, headers: headers, params: rt_params.to_json
        hash = json_parse(response.body)
        expected_error = {
          errors: [
            { 
              status: 400, 
              id: 'Origin', 
              title: 'Param is missing or the value is empty: origin' 
            },
            { 
              status: 400, 
              id: 'Destination', 
              title: 'Param is missing or the value is empty: destination' 
            },
            { 
              status: 401, 
              id: 'API Key', 
              title: 'Param is missing or the value is empty: api_key' 
            }
          ]
        }
        
        expect(response.status).to eq(400)
        expect(hash).to eq(expected_error)
      end

      it 'returns a unauthorized status when given invalid api key' do
        user =create(:user, email: 'user@email.com', password: '12345678')
        rt_params = { origin: 'denver,co', destination: 'estespark,co', api_key: 'not correct key' }
        post api_v1_road_trip_path, headers: headers, params: rt_params.to_json

        hash = json_parse(response.body)
        expected_error = {
          errors: [
            { 
              status: 401, 
              id: 'API Key', 
              title: 'Key does match user on file: api_key' 
            }
          ]
        }
        
        expect(response.status).to eq(401)
        expect(hash).to eq(expected_error)
      end
      
      it 'returns impossible time and empty weather when invalid route' do
        user =create(:user, email: 'user@email.com', password: '12345678')
        rt_params = { origin: 'denver,co', destination: 'london,uk', api_key: user.api_key }
        post api_v1_road_trip_path, headers: headers, params: rt_params.to_json

        hash = json_parse(response.body)
        attr = hash[:data][:attributes]

        expect(hash).to have_key(:data)
        expect(hash[:data]).to have_key(:id)
        expect(hash[:data][:id]).to eq(nil)

        expect(hash[:data]).to have_key(:type)
        expect(hash[:data][:type]).to eq('roadtrip')
        expect(hash[:data]).to have_key(:attributes)

        expect(attr).to have_key(:start_city)
        expect(attr[:start_city]).to be_a(String)
        expect(attr[:start_city]).to eq('denver,co')

        expect(attr).to have_key(:end_city)
        expect(attr[:end_city]).to be_a(String)
        expect(attr[:end_city]).to eq('london,uk')

        expect(attr).to have_key(:travel_time)
        expect(attr[:travel_time]).to be_a(String)
        expect(attr[:travel_time]).to eq('impossible')

        expect(attr).to have_key(:weather_at_eta)
        expect(attr[:weather_at_eta]).to be_a(Hash)
        expect(attr[:weather_at_eta].count).to eq(0)

        expect(attr[:weather_at_eta]).not_to have_key(:temperature)
        expect(attr[:weather_at_eta]).not_to have_key(:conditions)
      end
    end
  end
end