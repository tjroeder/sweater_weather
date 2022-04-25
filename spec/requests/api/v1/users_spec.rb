require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do

  path '/api/v1/users' do

    post('Creates a new User') do
      tags 'Users'
      description 'Creates a new user when given email and password with confirmation'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string, format: :email },
          password: { type: :string, minimum: 8 },
          password_confirmation: { type: :string }
        },
        required: %w[email password password_confirmation]
      }

      response(201, 'new user created') do
        let!(:user) { { email: 'example@email.com', password: 'password1', password_confirmation: 'password1' } }
        
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
