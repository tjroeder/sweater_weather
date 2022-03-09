require 'rails_helper'

RSpec.describe ForecastFacade, type: :facade do
  
  context 'class methods', :vcr do
    describe '::get_location_forecast' do
      context 'valid location request' do
        let!(:forecast) { ForecastFacade.get_location_forecast('denver,co') }

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

      context 'invalid location request' do
        it 'returns blank Forecast with error messages' do
          bad_location = ForecastFacade.get_location_forecast('zzzzzzzzzzzzzz')

          expected_error = { errors: [ { status: 400, title: 'Bad Request' }] }

          expect(bad_location).to be_a(Forecast)
          expect(bad_location.current_weather).to eq(expected_error)
          expect(bad_location.daily_weather).to eq(expected_error)
          expect(bad_location.hourly_weather).to eq(expected_error)
        end
      end
    end
  end
end
