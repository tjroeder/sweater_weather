require 'rails_helper'

RSpec.describe 'Sessions Request API', type: :request do
  let!(:headers) { 
                   { 
                     'CONTENT_TYPE' => 'application/json', 
                     'Accept' => 'application/json' 
                   } 
                 }

  context '#create action' do
    let!(:user) { create(:user, email: 'user@email.com', password: '12345678') }

    describe 'valid login request' do
      it 'returns successful status' do
        login_params = { email: 'user@email.com', password: '12345678' }
        post api_v1_sessions_path, headers: headers, params: login_params.to_json

        expect(response).to be_successful
      end

      it 'returns parsable json data response for forecast' do
        login_params = { email: 'user@email.com', password: '12345678' }
        post api_v1_sessions_path, headers: headers, params: login_params.to_json
        
        expect(json_parse(response.body)).to be_a(Hash)
      end

      it 'returns correct response attribute fields' do
        login_params = { email: 'user@email.com', password: '12345678' }
        post api_v1_sessions_path, headers: headers, params: login_params.to_json

        user = User.find_by(email: 'user@email.com')
        hash = json_parse(response.body)
        attr = hash[:data][:attributes]

        expect(hash).to have_key(:data)
        expect(hash[:data]).to have_key(:id)
        expect(hash[:data][:id]).to eq(user.id.to_s)
        expect(hash[:data][:type]).to eq('users')
        expect(attr).to have_key(:email)
        expect(attr).to have_key(:api_key)
        expect(attr[:email]).to be_a(String)
        expect(attr[:api_key]).to be_a(String)
        expect(attr[:email]).to eq(user[:email])
        expect(attr[:api_key]).to eq(user[:api_key])
      end
    end

    describe 'invalid login request' do
      it 'returns unsuccessful status' do
        login_params = { email: 'user@email.com', password: '1234' }
        post api_v1_sessions_path, headers: headers, params: login_params.to_json

        expect(response.status).to eq(401)
      end

      it 'returns vague error message if user is not found' do
        login_params = { email: 'other_user@email.com', password: '12345678' }
        post api_v1_sessions_path, headers: headers, params: login_params.to_json
        expected_response = { 
                              errors: [
                                        { 
                                          status: 401, 
                                          id: 'login', 
                                          title: 'Invalid email and/or password' 
                                        }
                                      ] 
                            }
        
        expect(json_parse(response.body)).to eq(expected_response)
      end

      it 'returns vague error message if password is incorrect' do
        login_params = { email: 'user@email.com', password: '1234' }
        post api_v1_sessions_path, headers: headers, params: login_params.to_json
        expected_response = { 
                              errors: [
                                        { 
                                          status: 401, 
                                          id: 'login', 
                                          title: 'Invalid email and/or password' 
                                        }
                                      ] 
                            }
        
        expect(json_parse(response.body)).to eq(expected_response)
      end

      it 'returns error message if no email given' do
        login_params = { password: '12345678' }
        post api_v1_sessions_path, headers: headers, params: login_params.to_json
        expected_response = {
          errors: [
            { 
              status: 400,
              id: 'Email', 
              title: "Param is missing or the value is empty: email"
            }
          ]
        }
        
        expect(json_parse(response.body)).to eq(expected_response)
      end

      it 'returns error message if no password given' do
        login_params = { email: 'other_user@email.com' }
        post api_v1_sessions_path, headers: headers, params: login_params.to_json
        expected_response = {
          errors: [
            { 
              status: 400,
              id: 'Password', 
              title: "Param is missing or the value is empty: password"
            }
          ]
        }
        
        expect(json_parse(response.body)).to eq(expected_response)
      end

      it 'returns error message if no email and password given' do
        login_params = {}
        post api_v1_sessions_path, headers: headers, params: login_params.to_json
        expected_response = {
          errors: [
            { 
              status: 400,
              id: 'Email', 
              title: "Param is missing or the value is empty: email"
            },
            { 
              status: 400,
              id: 'Password', 
              title: "Param is missing or the value is empty: password"
            }
          ]
        }
        
        expect(json_parse(response.body)).to eq(expected_response)
      end
    end
  end
end