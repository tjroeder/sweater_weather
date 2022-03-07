class BackgroundService < ApplicationService
  def self.get_background(query)
    url = 'https://www.flickr.com/services/'
    response = conn(url).get('rest') do |req|
      req.params['api_key'] = ENV['flickr_key']
      req.params['text'] = query
      req.params['privacy_filter'] = 1
      req.params['safe_search'] = 1
      req.params['content_type'] = 1
      req.params['accuracy'] = 11
      req.params['media'] = 'photos'
      req.params['geo_context'] = 2
      req.params['method'] = 'flickr.photos.search'
      req.params['format'] = 'json'
      req.params['nojsoncallback'] = 1
      req.params['extras'] = 'license,owner_name,url_l,url_t'
    end
    
    json_parse(response.body)
  end
end