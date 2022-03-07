class BooksForecast
  attr_reader :destination,
              :forecast,
              :total_books_found,
              :books
  
  def initialize(destination, books_data, forecast)
    @destination = destination
    @forecast = BooksForecast.format_forecast(forecast)
    @total_books_found = books_data[:numFound]
    @books = BooksForecast.create_books(books_data[:docs])
  end

  def self.format_forecast(forecast)
    {
      summary: forecast.current_weather[:conditions],
      temperature: "#{forecast.current_weather[:temperature].to_i} F"
    }
  end

  def self.create_books(books_data)
    books_data.map do |book|
      {
        isbn: book[:isbn],
        title: book[:title],
        publisher: book[:publisher]
      }
    end
  end
end
