# Forecast Service
# Mapquest Service eturning latitude and longitude of a location
# returning a forecast for a latitude and longitude.

class ForecastService < ApplicationService
  def self.get_city_lat_lon(city_state)
    url = 'http://www.mapquestapi.com/geocoding/v1/'
    response = conn(url).get('address') do |req|
      req.params['key'] = ENV['mapquest_key']
      req.params['location'] = city_state
    end

    json_parse(response.body) # if response.status == 200
  end

  def self.get_forecast(latitude, longitude, units)
    url = 'https://api.openweathermap.org/data/2.5/'
    response = conn(url).get('onecall') do |req|
      req.params['appid'] = ENV['open_weather_key']
      req.params['lat'] = latitude
      req.params['lon'] = longitude
      req.params['units'] = units
      req.params['exclude'] = 'minutely,alerts'
    end

    json_parse(response.body) # if response.status == 200
  end
end
