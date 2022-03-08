# Roadtrip Service
# Mapquest Service returns mapquest route information

class RoadtripService < ApplicationService
  def self.get_route(from, to, unit)
    url = 'http://www.mapquestapi.com/directions/v2/'
    response = conn(url).get('route') do |req|
      req.params['key'] = ENV['mapquest_key']
      req.params['from'] = from
      req.params['to'] = to
      req.params['unit'] = unit
    end

    json_parse(response.body) # if response.status == 200
  end
end
