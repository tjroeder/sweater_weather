class Api::V1::BackgroundsController < ApplicationController
  def index
    @background = BackgroundFacade.get_location_image(loc_params[:location])
    json_response(BackgroundSerializer.new(@background))
  end

  private

  def loc_params
    params.permit(:location)
  end
end