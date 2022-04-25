require 'swagger_helper'

RSpec.describe 'api/v1/sessions', type: :request do
  let!(:user) { User.create!(email: 'example1@email.com', password: 'password1', password_confirmation: 'password1') }
  
  path '/api/v1/sessions' do

    post('Creates a new Session') do
      tags 'Sessions'
      description 'Creates a new user session given valid email and password'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :session, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string, format: :email },
          password: { type: :string, minimum: 8 }
        },
        required: %w[email password]
      }


      response(200, 'successful') do
        let(:session) { { email: 'example1@email.com', password: 'password1' } }

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
