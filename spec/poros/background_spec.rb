require 'rails_helper'

RSpec.describe Background, type: :poro do
  let!(:image_data) { 
                      {
                       id: '51134665750',
                       owner: '29544031@N02',
                       secret: 'f023eefeaf',
                       server: '65535',
                       farm: 66,
                       title: 'F9 A320-251N N334FR',
                       ispublic: 1,
                       isfriend: 0,
                       isfamily: 0,
                       license: '0',
                       ownername: 'kenjet',
                       url_l: 'https://live.staticflickr.com/65535/51134665750_f023eefeaf_b.jpg',
                       height_l: 402,
                       width_l: 1024,
                       url_t: 'https://live.staticflickr.com/65535/51134665750_f023eefeaf_t.jpg',
                       height_t: 39,
                       width_t: 100
                      }
                    }
  let!(:image) { Background.new(image_data, 'denver co evening snow') }

  context 'object properties' do
    it 'exists' do
      expect(image).to be_a(Background)
    end

    it 'has attributes, image links hash, credit hash and overall info' do
      expect(image).to have_attributes(id: nil)
      expect(image).to have_attributes(image_id: '51134665750')
      expect(image).to have_attributes(owner_id: '29544031@N02')
      expect(image).to have_attributes(secret_id: 'f023eefeaf')
      expect(image).to have_attributes(title: 'F9 A320-251N N334FR')
      expect(image).to have_attributes(location: 'denver co evening snow')
      expect(image).to have_attributes(license_num: '0')
      expect(image).to have_attributes(owner_name: 'kenjet')
      expect(image).to have_attributes(url_l: 'https://live.staticflickr.com/65535/51134665750_f023eefeaf_b.jpg')
      expect(image).to have_attributes(height_l: 402)
      expect(image).to have_attributes(width_l: 1024)
      expect(image).to have_attributes(url_t: 'https://live.staticflickr.com/65535/51134665750_f023eefeaf_t.jpg')
      expect(image).to have_attributes(height_t: 39)
      expect(image).to have_attributes(width_t: 100)
      
      expected_links = {
        large_url: 'https://live.staticflickr.com/65535/51134665750_f023eefeaf_b.jpg',
        large_height: 402,
        large_width: 1024,
        thumbnail_url: 'https://live.staticflickr.com/65535/51134665750_f023eefeaf_t.jpg',
        thumbnail_height: 39,
        thumbnail_width: 100
      }
      
      expect(image).to have_attributes(image_links: expected_links)
      
      expected_credit = {
        owner_name: 'kenjet',
        license: 'All Rights Reserved',
        license_url: '',
        source: 'Flickr',
        notice: 'This product uses the Flickr API but is not endorsed or certified by SmugMug, Inc.',
        terms_url: 'https://www.flickr.com/help/terms/api'
      }
      expect(image).to have_attributes(credit: expected_credit)
      
      expected_image_out = {
        image_id: '51134665750',
        owner_id: '29544031@N02',
        secret_id: 'f023eefeaf',
        title: 'F9 A320-251N N334FR',
        location: 'denver co evening snow',
        image_links: {
          large_url: 'https://live.staticflickr.com/65535/51134665750_f023eefeaf_b.jpg',
          large_height: 402,
          large_width: 1024,
          thumbnail_url: 'https://live.staticflickr.com/65535/51134665750_f023eefeaf_t.jpg',
          thumbnail_height: 39,
          thumbnail_width: 100
        },
        credit: {
          owner_name: 'kenjet',
          license: 'All Rights Reserved',
          license_url: '',
          source: 'Flickr',
          notice: 'This product uses the Flickr API but is not endorsed or certified by SmugMug, Inc.',
          terms_url: 'https://www.flickr.com/help/terms/api'
        }
      }
      
      expect(image).to have_attributes(image: expected_image_out)
      
    end

    it 'has attributes with correct datatypes' do
      expect(image.image_id).to be_a(String)
      expect(image.owner_id).to be_a(String)
      expect(image.secret_id).to be_a(String)
      expect(image.title).to be_a(String)
      expect(image.location).to be_a(String)
      expect(image.license_num).to be_a(String)
      expect(image.owner_name).to be_a(String)
      expect(image.url_l).to be_a(String)
      expect(image.height_l).to be_a(Integer)
      expect(image.width_l).to be_a(Integer)
      expect(image.url_t).to be_a(String)
      expect(image.height_t).to be_a(Integer)
      expect(image.width_t).to be_a(Integer)
      expect(image.image_links).to be_a(Hash)
      expect(image.credit).to be_a(Hash)
      expect(image.image).to be_a(Hash)
    end
  end
end