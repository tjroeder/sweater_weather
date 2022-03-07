class ForecastSerializer
  include JSONAPI::Serializer
  
  set_id :id
  set_type :forecast

  attributes :current_weather,
             :daily_weather,
             :hourly_weather
end