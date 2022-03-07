class BackgroundFacade
  def self.get_location_image(location)
    image = BackgroundService.get_background(location.concat(' skyline'))
    Background.new(image[:photos][:photo][0], location)
  end
end
