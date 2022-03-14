class RoadtripFacade
  def self.get_roadtrip(from, to, units)
    route_data = RoadtripService.get_route(from, to, units)[:route]
    location = ForecastService.get_city_lat_lon(to)
    lat = location[:results][0][:locations][0][:latLng][:lat]
    lng = location[:results][0][:locations][0][:latLng][:lng]
    forecast_data = ForecastService.get_forecast(lat, lng, 'imperial')

    Roadtrip.new(from, to, route_data, forecast_data)
    end
  end
end