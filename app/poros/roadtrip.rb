class Roadtrip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta
  
  def initialize(from, to, route_data, forecast_data)
    @id = nil
    @start_city = Roadtrip.format_city_state(route_data, from, 0)
    @end_city = Roadtrip.format_city_state(route_data, to, 1)
    @travel_time = Roadtrip.format_travel_time(route_data)
    @weather_at_eta = Roadtrip.find_weather(route_data, forecast_data)
  end

  def self.format_city_state(route_data, from_to, element)
    if route_data[:locations]
      "#{route_data[:locations][element][:adminArea5]}, #{route_data[:locations][element][:adminArea3]}" 
    else
      from_to
    end
  end

  def self.format_travel_time(travel_time)
    if travel_time[:time].is_a?(Integer)
      t = ActiveSupport::Duration.build(travel_time[:time]).parts
      format("%d hour(s), %d min(s)", (t[:days] * 24) + t[:hours], t[:minutes])
    else
      'impossible'
    end
  end

  def self.find_weather(travel_time, forecast_data)
    if travel_time[:time].is_a?(Integer)
      eta = Time.at(forecast_data[:current][:dt] + travel_time[:time]).end_of_hour.round
      closest_time = forecast_data[:hourly].select do |elm|
        elm[:dt] == eta.to_i
      end

      {
        temperature: closest_time[0][:temp],
        conditions: closest_time[0][:weather][0][:description]
      }
    else
      {}
    end
  end
end