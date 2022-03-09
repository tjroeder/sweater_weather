class Api::V1::ForecastController < ApplicationController
  def index
    @forecast = ForecastFacade.get_location_forecast(loc_params)
    if @forecast.current_weather[:datetime].present?
      json_response(ForecastSerializer.new(@forecast))
    else
      json_response(ForecastSerializer.new(@forecast), :bad_request)
    end
  end

  private

  def loc_params
    params.permit(:location)
  end
end