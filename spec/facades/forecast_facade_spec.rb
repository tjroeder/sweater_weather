require 'rails_helper'

RSpec.describe ForecastFacade, type: :facade do
  let!(:forecast) { ForecastFacade.get_location_forecast('denver,co') }

  context 'class methods', :vcr do
    describe '::get_location_forecast' do
      it 'returns a Forecast object' do
        expect(forecast).to be_a(Forecast)
      end

      it 'returns a Forecast object with the the current weather' do
        expect(forecast.current_weather.count).to eq(10)
      end

      it 'returns a Forecast object with the next 5 days of weather data' do
        expect(forecast.daily_weather.count).to eq(5)
      end

      it 'returns a Forecast object with the next 8 hours of weather data' do
        expect(forecast.hourly_weather.count).to eq(8)
      end
    end
  end
end
