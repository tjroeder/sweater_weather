class Api::V1::BooksController < ApplicationController
  def book_search
    @quantity = search_params[:quantity].to_i
    @location = search_params[:location]
    if @quantity > 0
      @books = BooksFacade.destination_book_search(@location, @quantity)
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
    params.permit(:location, :quantity)
  end
end