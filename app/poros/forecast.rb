class Forecast
  attr_reader :id,
              :timezone_offset,
              :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(data)
    @id = nil
    @timezone_offset = data[:timezone_offset]
    @current_weather = Forecast.current_weather(data[:current])
    @daily_weather = Forecast.daily_weather(data[:daily])
    @hourly_weather = Forecast.hourly_weather(data[:hourly])
  end

  def self.current_weather(data)
    {
      datetime: Time.at(data[:dt]).to_s,
      sunrise: Time.at(data[:sunrise]).to_s,
      sunset: Time.at(data[:sunset]).to_s,
      temperature: data[:temp],
      feels_like: data[:feels_like],
      humidity: data[:humidity],
      uvi: data[:uvi],
      visibility: data[:visibility],
      conditions: data[:weather][0][:description],
      icon: data[:weather][0][:icon]
    }
  end

  def self.daily_weather(data)
    data.map.with_index do |daily, index|
      {
        date: Time.at(daily[:dt]).strftime('%F').to_s,
        sunrise: Time.at(daily[:sunrise]).to_s,
        sunset: Time.at(daily[:sunset]).to_s,
        max_temp: daily[:temp][:max],
        min_temp: daily[:temp][:min],
        conditions: daily[:weather][0][:description],
        icon: daily[:weather][0][:icon]
      }
    end
  end

  def self.hourly_weather(data)
    data.map.with_index do |hourly, index|
      {
        time: Time.at(hourly[:dt]).strftime('%T').to_s,
        temperature: hourly[:temp],
        conditions: hourly[:weather][0][:description],
        icon: hourly[:weather][0][:icon]
      }
    end
  end
end
