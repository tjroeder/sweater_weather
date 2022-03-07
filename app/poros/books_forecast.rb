class BooksForecast
  attr_reader :destination,
              :forecast,
              :total_books_found,
              :books
  
  def initialize(destination, book_data, forecast)
    @destination = destination
    @forecast = BooksForecast.format_forecast(forecast)
    @total_books = book_data[:numFound]
    @books = BooksForecast.create_books(book_data[:docs])
  end

  def self.format_forecast(forecast)
    
  end

  def self.create_books(book_data)

  end
end