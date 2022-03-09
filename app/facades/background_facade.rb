class BackgroundFacade
  def self.get_location_image(location)
    image = BackgroundService.get_background(location.concat(' skyline'))
    unless image[:photos][:photo].empty?
      Background.new(image[:photos][:photo][0], location)
    else
      Background.new(self.no_images_found, location)
    end
  end

  def self.no_images_found
    {
      id: nil,
      owner: nil,
      secret: nil,
      title: 'NO IMAGE FOUND',
      license: nil,
      ownername: nil,
      url_l: nil,
      height_l: nil,
      width_l: nil,
      url_t: nil,
      height_t: nil,
      width_t: nil
    }
  end
end
