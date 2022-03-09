class ForecastFacade
  def self.get_location_forecast(city_state)
    location = ForecastService.get_city_lat_lon(city_state)
    
    if location[:results][0][:locations][0][:adminArea5].present?
      lat = location[:results][0][:locations][0][:latLng][:lat]
      lng = location[:results][0][:locations][0][:latLng][:lng]

      cast = Forecast.new(ForecastService.get_forecast(lat, lng, 'imperial'))
      cast.daily_weather.slice!(-3..-1)
      cast.hourly_weather.slice!(-40..-1)
      cast
    else
      Forecast.new({})
    end
  end
end
