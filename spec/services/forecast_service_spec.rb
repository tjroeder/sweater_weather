require 'rails_helper'

RSpec.describe ForecastService, type: :service do
  context 'class methods', :vcr do
    describe '::get_city_lat_lon' do
      it 'returns a response hash' do
        lat_lon = ForecastService.get_city_lat_lon('denver,co')

        expect(lat_lon).to be_a(Hash)
      end
    end

    describe '::get_forecast' do
      it 'returns a response object' do
        forecast = ForecastService.get_forecast(39.738453, -104.984853, 'imperial')
        
        expect(forecast).to be_a(Hash)
      end
    end
  end
end
