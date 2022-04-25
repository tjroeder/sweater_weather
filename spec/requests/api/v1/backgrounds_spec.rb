require 'swagger_helper'

RSpec.describe 'api/v1/backgrounds', type: :request do

  path '/api/v1/backgrounds' do

    get('Returns a single background photo') do
      tags 'Background'
      description 'Retreives a background photo from Flickr'
      produces 'application/json'
      parameter name: :location, in: :query, type: :string, required: true, description: 'city, state'
      
      response(200, 'successful') do
        let(:location) { 'denver,co' }

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
