require 'swagger_helper'

RSpec.describe 'api/v1/roadtrip', type: :request do
  let(:user) { User.create!(email: 'example1@email.com', password: 'password1', password_confirmation: 'password1') }

  path '/api/v1/road_trip' do

    post('Creates a new Roadtrip') do
      tags 'Roatrips'
      description 'Creates a new roadtrip given valid origin, destination and api key'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :roadtrip, in: :body, schema: {
        type: :object,
        properties: {
          origin: { type: :string },
          destination: { type: :string },
          api_key: { type: :string }
        },
        required: %w[origin destination api_key]
      }

      response(200, 'successful') do
        let(:roadtrip) { { origin: 'denver,co', destination: 'durango,co', api_key: user.api_key } }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
