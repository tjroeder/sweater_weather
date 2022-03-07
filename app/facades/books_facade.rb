class BooksFacade
  def self.destination_book_search(destination, quantity)
    forecast = ForecastFacade.get_location_forecast(destination)
    book_data = BookService.get_destination_books(destination, quantity)
    BooksForecast.new(destination, book_data, forecast)
  end
end