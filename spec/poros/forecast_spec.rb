require 'rails_helper'

RSpec.describe Forecast, :vcr, type: :poro do
  let!(:denver) { ForecastService.get_forecast(39.738453, -104.984853, 'imperial') }
  let!(:forecast) { Forecast.new(denver) }

  context 'object properties' do
    it 'exists' do
      expect(forecast).to be_a(Forecast)
    end

    it 'has attributes' do
      expect(forecast).to have_attributes(id: nil)
      expect(forecast).to have_attributes(timezone_offset: -25200)
      expected_current = { 
                           datetime: "2022-03-06 07:27:30 UTC",
                           sunrise: "2022-03-06 13:25:35 UTC", 
                           sunset: "2022-03-07 00:57:04 UTC", 
                           temperature: 22.93, 
                           feels_like: 19.06, 
                           humidity: 84, 
                           uvi: 0, 
                           visibility: 10000, 
                           conditions: "overcast clouds", 
                           icon: "04n"
                         }
      
      expect(forecast).to have_attributes(current_weather: expected_current)
      expect(forecast.current_weather).to be_a(Hash)
      expect(forecast.current_weather.count).to eq(10)
      expect(forecast.current_weather[:datetime]).to be_a(String)
      expect(forecast.current_weather[:sunrise]).to be_a(String)
      expect(forecast.current_weather[:sunset]).to be_a(String)
      expect(forecast.current_weather[:temperature]).to be_a(Float)
      expect(forecast.current_weather[:feels_like]).to be_a(Float)
      expect(forecast.current_weather[:humidity]).to be_a(Integer)
      expect(forecast.current_weather[:uvi]).to be_a(Integer)
      expect(forecast.current_weather[:visibility]).to be_a(Integer)
      expect(forecast.current_weather[:conditions]).to be_a(String)
      expect(forecast.current_weather[:icon]).to be_a(String)

      expected_daily = [
                         { 
                           date: "2022-03-06", 
                           sunrise: "2022-03-06 13:25:35 UTC", 
                           sunset: "2022-03-07 00:57:04 UTC", 
                           max_temp: 28.27, 
                           min_temp: 20.86, 
                           conditions: "snow", 
                           icon: "13d"
                         },
                         {
                           date: "2022-03-07", 
                           sunrise: "2022-03-07 13:24:02 UTC", 
                           sunset: "2022-03-08 00:58:07 UTC", 
                           max_temp: 31.82, 
                           min_temp: 18.9, 
                           conditions: "clear sky", 
                           icon: "01d"
                         },
                         {
                           date: "2022-03-08", 
                           sunrise: "2022-03-08 13:22:28 UTC", 
                           sunset: "2022-03-09 00:59:10 UTC", 
                           max_temp: 39.43, 
                           min_temp: 24.44, 
                           conditions: "few clouds", 
                           icon: "02d"
                         },
                         {
                           date: "2022-03-09", 
                           sunrise: "2022-03-09 13:20:54 UTC", 
                           sunset: "2022-03-10 01:00:13 UTC", 
                           max_temp: 34.23, 
                           min_temp: 18.23, 
                           conditions: "snow", 
                           icon: "13d"
                         },
                         {
                           date: "2022-03-10", 
                           sunrise: "2022-03-10 13:19:20 UTC", 
                           sunset: "2022-03-11 01:01:16 UTC", 
                           max_temp: 26.29, 
                           min_temp: 13.82, 
                           conditions: "light snow", 
                           icon: "13d"
                         },
                         {
                           date: "2022-03-11", 
                           sunrise: "2022-03-11 13:17:45 UTC", 
                           sunset: "2022-03-12 01:02:18 UTC", 
                           max_temp: 41.54, 
                           min_temp: 20.19, 
                           conditions: "broken clouds", 
                           icon: "04d"
                         },
                         {
                           date: "2022-03-12", 
                           sunrise: "2022-03-12 13:16:09 UTC", 
                           sunset: "2022-03-13 01:03:20 UTC", 
                           max_temp: 51.6, 
                           min_temp: 29.52, 
                           conditions: "few clouds", 
                           icon: "02d"
                         },
                         {
                           date: "2022-03-13", 
                           sunrise: "2022-03-13 13:14:33 UTC", 
                           sunset: "2022-03-14 01:04:22 UTC", 
                           max_temp: 59.07, 
                           min_temp: 36.61, 
                           conditions: "broken clouds", 
                           icon: "04d"
                         }
                       ]
      expect(forecast).to have_attributes(daily_weather: expected_daily)
      expect(forecast.daily_weather).to be_a(Array)
      expect(forecast.daily_weather.count).to eq(8)
      
      forecast.daily_weather.each do |day|
        expect(day[:date]).to be_a(String)
        expect(day[:sunrise]).to be_a(String)
        expect(day[:sunset]).to be_a(String)
        expect(day[:max_temp]).to be_a(Float)
        expect(day[:min_temp]).to be_a(Float)
        expect(day[:conditions]).to be_a(String)
        expect(day[:icon]).to be_a(String)
      end

      expected_hourly = [
                          {
                            time: "00:00:00", 
                            temperature: 22.93, 
                            conditions: "overcast clouds", 
                            icon: "04n"
                          },
                          {
                            time: "01:00:00", 
                            temperature: 23.65, 
                            conditions: "overcast clouds", 
                            icon: "04n"
                          },
                          {
                            time: "02:00:00", 
                            temperature: 24.03, 
                            conditions: "light snow", 
                            icon: "13n"
                          },
                          {
                            time: "03:00:00", 
                            temperature: 24.26, 
                            conditions: "light snow", 
                            icon: "13n"
                          },
                          {
                            time: "04:00:00", 
                            temperature: 24.57, 
                            conditions: "light snow", 
                            icon: "13n"
                          },
                          {
                            time: "05:00:00", 
                            temperature: 24.76, 
                            conditions: "overcast clouds", 
                            icon: "04n"
                          },
                          {
                            time: "06:00:00", 
                            temperature: 24.33, 
                            conditions: "light snow", 
                            icon: "13n"
                          },
                          {
                            time: "07:00:00", 
                            temperature: 24.19, 
                            conditions: "light snow", 
                            icon: "13d"
                          },
                          {
                            time: "08:00:00", 
                            temperature: 24.64, 
                            conditions: "light snow", 
                            icon: "13d"
                          },
                          {
                            time: "09:00:00", 
                            temperature: 25.05, 
                            conditions: "light snow", 
                            icon: "13d"
                          },
                          {
                            time: "10:00:00", 
                            temperature: 25.81, 
                            conditions: "light snow", 
                            icon: "13d"
                          },
                          {
                            time: "11:00:00", 
                            temperature: 26.8, 
                            conditions: "light snow", 
                            icon: "13d"
                          },
                          {
                            time: "12:00:00", 
                            temperature: 27.66, 
                            conditions: "light snow", 
                            icon: "13d"
                          },
                          {
                            time: "13:00:00", 
                            temperature: 27.27, 
                            conditions: "light snow", 
                            icon: "13d"
                          },
                          {
                            time: "14:00:00", 
                            temperature: 28.27, 
                            conditions: "light snow", 
                            icon: "13d"
                          },
                          {
                            time: "15:00:00", 
                            temperature: 27.64, 
                            conditions: "light snow", 
                            icon: "13d"
                          },
                          {
                            time: "16:00:00", 
                            temperature: 27.59, 
                            conditions: "light snow", 
                            icon: "13d"
                          },
                          {
                            time: "17:00:00", 
                            temperature: 26.06, 
                            conditions: "light snow", 
                            icon: "13d"
                          },
                          {
                            time: "18:00:00", 
                            temperature: 24.75, 
                            conditions: "snow", 
                            icon: "13n"
                          },
                          {
                            time: "19:00:00", 
                            temperature: 23.95, 
                            conditions: "snow", 
                            icon: "13n"
                          },
                          {
                            time: "20:00:00", 
                            temperature: 23.05, 
                            conditions: "light snow", 
                            icon: "13n"
                          },
                          {
                            time: "21:00:00", 
                            temperature: 22.32, 
                            conditions: "light snow", 
                            icon: "13n"
                          },
                          {
                            time: "22:00:00", 
                            temperature: 21.56, 
                            conditions: "light snow", 
                            icon: "13n"
                          },
                          {
                            time: "23:00:00", 
                            temperature: 20.86, 
                            conditions: "overcast clouds", 
                            icon: "04n"
                          },
                          {
                            time: "00:00:00", 
                            temperature: 20.28, 
                            conditions: "overcast clouds", 
                            icon: "04n"
                          },
                          {
                            time: "01:00:00", 
                            temperature: 20.1, 
                            conditions: "overcast clouds", 
                            icon: "04n"
                          },
                          {
                            time: "02:00:00", 
                            temperature: 19.89, 
                            conditions: "overcast clouds", 
                            icon: "04n"
                          },
                          {
                            time: "03:00:00", 
                            temperature: 19.83, 
                            conditions: "overcast clouds", 
                            icon: "04n"
                          },
                          {
                            time: "04:00:00", 
                            temperature: 19.54, 
                            conditions: "overcast clouds", 
                            icon: "04n"
                          },
                          {
                            time: "05:00:00", 
                            temperature: 19.15, 
                            conditions: "overcast clouds", 
                            icon: "04n"
                          },
                          {
                            time: "06:00:00", 
                            temperature: 18.9, 
                            conditions: "overcast clouds", 
                            icon: "04n"
                          },
                          {
                            time: "07:00:00", 
                            temperature: 19.17, 
                            conditions: "overcast clouds", 
                            icon: "04d"
                          },
                          {
                            time: "08:00:00", 
                            temperature: 20.52, 
                            conditions: "overcast clouds", 
                            icon: "04d"
                          },
                          {
                            time: "09:00:00", 
                            temperature: 22.62, 
                            conditions: "overcast clouds", 
                            icon: "04d"
                          },
                          {
                            time: "10:00:00", 
                            temperature: 24.46, 
                            conditions: "overcast clouds", 
                            icon: "04d"
                          },
                          {
                            time: "11:00:00", 
                            temperature: 26.55, 
                            conditions: "broken clouds", 
                            icon: "04d"
                          },
                          {
                            time: "12:00:00", 
                            temperature: 28.8, 
                            conditions: "clear sky", 
                            icon: "01d"
                          },
                          {
                            time: "13:00:00", 
                            temperature: 30.54, 
                            conditions: "few clouds", 
                            icon: "02d"
                          },
                          {
                            time: "14:00:00", 
                            temperature: 31.62, 
                            conditions: "scattered clouds", 
                            icon: "03d"
                          },
                          {
                            time: "15:00:00", 
                            temperature: 31.82, 
                            conditions: "broken clouds", 
                            icon: "04d"
                          },
                          {
                            time: "16:00:00", 
                            temperature: 31.41, 
                            conditions: "broken clouds", 
                            icon: "04d"
                          },
                          {
                            time: "17:00:00", 
                            temperature: 30.99, 
                            conditions: "broken clouds", 
                            icon: "04d"
                          },
                          {
                            time: "18:00:00", 
                            temperature: 29.66, 
                            conditions: "overcast clouds", 
                            icon: "04n"
                          },
                          {
                            time: "19:00:00", 
                            temperature: 28.62, 
                            conditions: "overcast clouds", 
                            icon: "04n"
                          },
                          {
                            time: "20:00:00", 
                            temperature: 28.02, 
                            conditions: "broken clouds", 
                            icon: "04n"
                          },
                          {
                            time: "21:00:00", 
                            temperature: 28.08, 
                            conditions: "broken clouds", 
                            icon: "04n"
                          },
                          {
                            time: "22:00:00", 
                            temperature: 27.82, 
                            conditions: "broken clouds", 
                            icon: "04n"
                          },
                          {
                            time: "23:00:00", 
                            temperature: 27.63, 
                            conditions: "scattered clouds", 
                            icon: "03n"
                          }
                        ]
      
      expect(forecast).to have_attributes(hourly_weather: expected_hourly)
      expect(forecast.hourly_weather).to be_a(Array)
      expect(forecast.hourly_weather.count).to eq(48)

      forecast.hourly_weather.each do |hour|
        expect(hour[:time]).to be_a(String)
        expect(hour[:temperature]).to be_a(Float)
        expect(hour[:conditions]).to be_a(String)
        expect(hour[:icon]).to be_a(String)
      end
    end

    context 'invalid service data' do
      it 'returns error messages' do
        bad_forecast = Forecast.new({})
        expected_error = { errors: [ { status: 400, title: 'Bad Request' }] }

        expect(bad_forecast).to be_a(Forecast)
        expect(bad_forecast.current_weather).to eq(expected_error)
        expect(bad_forecast.daily_weather).to eq(expected_error)
        expect(bad_forecast.hourly_weather).to eq(expected_error)
      end
    end
  end
end
