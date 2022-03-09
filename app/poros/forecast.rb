class Forecast
  attr_reader :id,
              :timezone_offset,
              :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(data)
    @id = nil
    @timezone_offset = data[:timezone_offset]
    @current_weather = Forecast.current_weather(data)
    @daily_weather = Forecast.daily_weather(data)
    @hourly_weather = Forecast.hourly_weather(data)
  end

  def self.current_weather(data)
    if data[:current].present?
      {
        datetime: Time.at(data[:current][:dt]).to_s,
        sunrise: Time.at(data[:current][:sunrise]).to_s,
        sunset: Time.at(data[:current][:sunset]).to_s,
        temperature: data[:current][:temp],
        feels_like: data[:current][:feels_like],
        humidity: data[:current][:humidity],
        uvi: data[:current][:uvi],
        visibility: data[:current][:visibility],
        conditions: data[:current][:weather][0][:description],
        icon: data[:current][:weather][0][:icon]
      }
    else
      { errors: [ { status: 400, title: 'Bad Request' }] }
    end
  end

  def self.daily_weather(data)
    if data[:daily].present?
      data[:daily].map.with_index do |daily, index|
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
    else
      { errors: [ { status: 400, title: 'Bad Request' }] }
    end
  end

  def self.hourly_weather(data)
    if data[:hourly].present?
      data[:hourly].map.with_index do |hourly, index|
        {
          time: Time.at(hourly[:dt]).strftime('%T').to_s,
          temperature: hourly[:temp],
          conditions: hourly[:weather][0][:description],
          icon: hourly[:weather][0][:icon]
        }
      end
    else
      { errors: [ { status: 400, title: 'Bad Request' }] }
    end
  end
end
