class BooksFacade
  def self.destination_book_search(destination, quantity)
    forecast = ForecastFacade.get_location_forecast(destination)
    book_data = BookService.get_destination_books(destination)
    book_forecast = BooksForecast.new(destination, book_data, forecast)
    book_count = book_forecast.books.count
    book_forecast.books.slice!((quantity - book_count)..-1)
    book_forecast
  end
end