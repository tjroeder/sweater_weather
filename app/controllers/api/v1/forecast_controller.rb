class Api::V1::ForecastController < ApplicationController
  def index
    @forecast = ForecastFacade.get_location_forecast(loc_params)
    json_response(ForecastSerializer.new(@forecast))
  end

  private

  def loc_params
    params.permit(:location)
  end
end