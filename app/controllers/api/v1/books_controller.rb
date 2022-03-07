class Api::V1::BooksController < ApplicationController
  def books_search
    if search_params[:quantity] > 0
      @books = BooksFacade.destination_book_search(search_params)
      json_response(BooksForecastSerializer.new(@books))
    else
      json_response(wrong_quantity_error, :bad_request)
    end
  end

  private

  def wrong_quantity_error
    {
      errors: [
        status: 400,
        detail: 'Incorrect quantity given, must be greater than 0' 
      ]
    }
  end

  def search_params
    params.require(:location, :quantity)
  end
end