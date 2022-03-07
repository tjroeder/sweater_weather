require 'rails_helper'

RSpec.describe ApplicationService, type: :service do
  context 'class methods' do
    describe '::conn' do
      it 'returns Faraday connection' do
        connection = ApplicationService.conn('http://www.mapquestapi.com/geocoding/v1/')

        expect(connection).to be_a(Faraday::Connection)
      end
    end

    describe '::json_parse', :vcr do
      it 'parses json response body to hash' do
        json = ApplicationService.conn('https://api.github.com/repos/tjroeder/sweater_weather').get

        hash = ApplicationService.json_parse(json.body)

        expect(hash).to be_a(Hash)
      end
    end
  end
end