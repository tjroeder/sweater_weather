class BooksForecast
  attr_reader :destination,
              :forecast,
              :total_books,
              :books
  
  def initialize(destination, book_data, forecast)
    @destination = destination
    @books = BooksForecast.create_books(book_data[:docs])
    
  end
end