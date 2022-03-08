require 'rails_helper'

RSpec.describe 'Users Request API', type: :request do
  let!(:headers) { 
                   { 
                     'CONTENT_TYPE' => 'application/json', 
                     'Accept' => 'application/json' 
                   } 
                 }

  context '#create action' do
    describe 'valid request' do
      it 'returns successful status' do
        user_params = { email: 'user@email.com', password: '12345678', password_confirmation: '12345678' }
        post api_v1_users_path, headers: headers, params: user_params.to_json

        expect(response).to be_successful
      end

      it 'returns parsable json data response for forecast' do
        user_params = { email: 'user@email.com', password: '12345678', password_confirmation: '12345678' }
        post api_v1_users_path, headers: headers, params: user_params.to_json
        
        expect(json_parse(response.body)).to be_a(Hash)
      end

      it 'returns correct response attribute fields' do
        user_params = { email: 'user@email.com', password: '12345678', password_confirmation: '12345678' }
        post api_v1_users_path, headers: headers, params: user_params.to_json

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

    describe 'invalid request' do
      it 'returns unsuccessful status' do
        user_params = { email: 'user@email.com', password: '12345678', password_confirmation: '123' }
        post api_v1_users_path, headers: headers, params: user_params.to_json

        expect(response.status).to eq(400)
      end

      it 'returns error message if email is already taken' do
        create(:user, email: 'user@email.com')
        user_params = { email: 'user@email.com', password: '12345678', password_confirmation: '12345678' }
        post api_v1_users_path, headers: headers, params: user_params.to_json
        expected_response = {
          errors: [
            { 
              status: 400,
              source: { pointer: '/api/v1/users' },
              id: 'email', 
              title: "has already been taken" 
            }
          ]
        }
        
        expect(json_parse(response.body)).to eq(expected_response)
      end

      it 'returns error message if no email given' do
        user_params = { password: '12345678', password_confirmation: '12345678' }
        post api_v1_users_path, headers: headers, params: user_params.to_json
        expected_response = {
          errors: [
            { 
              status: 400,
              source: { pointer: '/api/v1/users' },
              id: 'email', 
              title: "is invalid" 
            },
            { 
              status: 400,
              source: { pointer: '/api/v1/users' },
              id: 'email', 
              title: "can't be blank" 
            }
          ]
        }
        
        expect(json_parse(response.body)).to eq(expected_response)
      end

      it 'returns error message for not matching password confirmation' do
        user_params = { email: 'user@email.com', password: '12345678', password_confirmation: '123' }
        post api_v1_users_path, headers: headers, params: user_params.to_json
        expected_response = {
          errors: [
            { 
              status: 400,
              source: { pointer: '/api/v1/users' },
              id: 'password_confirmation', 
              title: "doesn't match Password" 
            }
          ]
        }
        
        expect(json_parse(response.body)).to eq(expected_response)
      end

      it 'returns error message for too short of password' do
        user_params = { email: 'user@email.com', password: '12345', password_confirmation: '12345' }
        post api_v1_users_path, headers: headers, params: user_params.to_json
        expected_response = {
          errors: [
            { 
              status: 400,
              source: { pointer: '/api/v1/users' },
              id: 'password', 
              title: "is too short (minimum is 8 characters)" 
            }
          ]
        }
        
        expect(json_parse(response.body)).to eq(expected_response)
      end

      it 'returns error message if no password given' do
        user_params = { email: 'user@email.com', password_confirmation: '12345678' }
        post api_v1_users_path, headers: headers, params: user_params.to_json
        expected_response = {
          errors: [
            { 
              status: 400,
              source: { pointer: '/api/v1/users' },
              id: 'password', 
              title: "can't be blank" 
            },
            { 
              status: 400,
              source: { pointer: '/api/v1/users' },
              id: 'password', 
              title: "is too short (minimum is 8 characters)" 
            },
            { 
              status: 400,
              source: { pointer: '/api/v1/users' },
              id: 'password_digest', 
              title: "can't be blank" 
            }
          ]
        }
        
        expect(json_parse(response.body)).to eq(expected_response)
      end

      it 'returns error message if no password confirmation given' do
        user_params = { email: 'user@email.com', password: '12345678' }
        post api_v1_users_path, headers: headers, params: user_params.to_json
        expected_response = {
          errors: [
            { 
              status: 400,
              source: { pointer: '/api/v1/users' },
              id: 'password_confirmation', 
              title: "can't be blank"
            }
          ]
        }
        
        expect(json_parse(response.body)).to eq(expected_response)
      end
    end
  end
end