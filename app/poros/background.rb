class Background
  attr_reader :id,
              :image_id,
              :owner_id,
              :secret_id,
              :title,
              :location,
              :license_num,
              :owner_name,
              :url_l,
              :height_l,
              :width_l,
              :url_t,
              :height_t,
              :width_t,
              :image_links,
              :credit,
              :image

  def initialize(data, query)
    @id = nil
    @image_id = data[:id]
    @owner_id = data[:owner]
    @secret_id = data[:secret]
    @title = data[:title]
    @location = query
    @license_num = data[:license]
    @owner_name = data[:ownername]
    @url_l = data[:url_l]
    @height_l = data[:height_l]
    @width_l = data[:width_l]
    @url_t = data[:url_t]
    @height_t = data[:height_t]
    @width_t = data[:width_t]
    @image_links = Background.image_links_hash(data)
    @credit = Background.credit_hash(data)
    @image = Background.image_hash(data, query)
  end

  def self.image_links_hash(data)
    {
      large_url: data[:url_l],
      large_height: data[:height_l],
      large_width: data[:width_l],
      thumbnail_url: data[:url_t],
      thumbnail_height: data[:height_t],
      thumbnail_width: data[:width_t]
    }
  end
  
  def self.credit_hash(data)
    {
      owner_name: data[:ownername],
      license: Background.license_info[data[:license].to_sym][0],
      license_url: Background.license_info[data[:license].to_sym][1],
      source: 'Flickr',
      notice: 'This product uses the Flickr API but is not endorsed or certified by SmugMug, Inc.',
      terms_url: 'https://www.flickr.com/help/terms/api'
    }
  end

  def self.license_info
    { 
      '0': ['All Rights Reserved', ''],
      '1': ['Attribution-NonCommercial-ShareAlike License','https://creativecommons.org/licenses/by-nc-sa/2.0/'],
      '2': ['Attribution-NonCommercial License','https://creativecommons.org/licenses/by-nc/2.0/'],
      '3': ['Attribution-NonCommercial-NoDerivs License','https://creativecommons.org/licenses/by-nc-nd/2.0/'],
      '4': ['Attribution License', 'https://creativecommons.org/licenses/by/2.0/'],
      '5': ['Attribution-ShareAlike License', 'https://creativecommons.org/licenses/by-sa/2.0/'],
      '6': ['Attribution-NoDerivs License', 'https://creativecommons.org/licenses/by-nd/2.0/'],
      '7': ['No known copyright restrictions', 'https://www.flickr.com/commons/usage/'],
      '8': ['United States Government Work', 'http://www.usa.gov/copyright.shtml'],
      '9': ['Public Domain Dedication (CC0)', 'https://creativecommons.org/publicdomain/zero/1.0/'],
      '10': ['Public Domain Mark', 'https://creativecommons.org/publicdomain/mark/1.0/']
    }
  end

  def self.image_hash(data, query)
    {
      image_id: data[:id],
      owner_id: data[:owner],
      secret_id: data[:secret],
      title: data[:title],
      location: query,
      image_links: Background.image_links_hash(data),
      credit: Background.credit_hash(data)
    }
  end
end