class Api::V1::RoadtripController < ApplicationController
  before_action :road_trip_params
  before_action :check_for_params
  before_action :verify_api_key

  def create
    @roadtrip = RoadtripFacade.get_roadtrip(@rt_params[:origin], @rt_params[:destination], 'm')
    if @roadtrip.travel_time == 'impossible'
      json_response(RoadtripSerializer.new(@roadtrip), :bad_request)
    else
      json_response(RoadtripSerializer.new(@roadtrip), :ok)
    end
  end

  private

  def road_trip_params
    @rt_params = params.permit(:origin, :destination, :api_key)
  end

  def check_for_params
    unless @rt_params[:origin].present? && @rt_params[:destination].present? && @rt_params[:api_key].present?
      error_hash = { errors: [] }

      error_hash[:errors].push({ status: 400, id: 'Origin', title: 'Param is missing or the value is empty: origin' }) unless @rt_params[:origin]

      error_hash[:errors].push({ status: 400, id: 'Destination', title: 'Param is missing or the value is empty: destination' }) unless @rt_params[:destination]

      error_hash[:errors].push({ status: 401, id: 'API Key', title: 'Param is missing or the value is empty: api_key' }) unless @rt_params[:api_key]
      json_response(error_hash, :bad_request)
    end
  end

  def verify_api_key
    user = User.find_by(api_key: @rt_params[:api_key])
    error_hash = { errors: [] }

    unless user
      error_hash[:errors].push({ status: 401, id: 'API Key', title: 'Key does match user on file: api_key' })

      json_response(error_hash, :unauthorized)
    end
  end
end
