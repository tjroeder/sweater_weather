class ForecastFacade
  def self.get_location_forecast(city_state)
    location = ForecastService.get_city_lat_lon(city_state)
    lat = location[:results][0][:locations][0][:latLng][:lat]
    lng = location[:results][0][:locations][0][:latLng][:lng]

    forecast = Forecast.new(ForecastService.get_forecast(lat, lng, 'imperial'))
    forecast.daily_weather.slice!(-3..-1)
    forecast.hourly_weather.slice!(-40..-1)
    forecast
  end
end
