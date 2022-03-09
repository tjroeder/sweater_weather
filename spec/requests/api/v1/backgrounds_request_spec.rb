require 'rails_helper'

RSpec.describe 'Backgrounds Request API', :vcr, type: :request do
  context '#index action' do
    context 'valid search of image api' do
      it 'returns a successful status when given valid location' do
        get api_v1_backgrounds_path(params: { location: 'denver,co' })
        
        expect(response).to be_successful
      end
      
      it 'returns parsable json data response for background' do
        get api_v1_backgrounds_path(params: { location: 'denver,co' })
        
        expect(json_parse(response.body)).to be_a(Hash)
      end
      
      it 'returns correct response attribute fields' do
        get api_v1_backgrounds_path(params: { location: 'denver,co' })
        hash = json_parse(response.body)
        attr = hash[:data][:attributes]
    
        expect(hash).to have_key(:data)
        expect(hash[:data]).to have_key(:id)
        expect(hash[:data][:id]).to eq(nil)
        expect(hash[:data][:type]).to eq('image')
    
        expect(attr).to have_key(:image)
    
        expect(attr[:image]).to have_key(:image_id)
        expect(attr[:image]).to have_key(:owner_id)
        expect(attr[:image]).to have_key(:secret_id)
        expect(attr[:image]).to have_key(:title)
        expect(attr[:image]).to have_key(:location)
        expect(attr[:image]).to have_key(:image_links)
        expect(attr[:image]).to have_key(:credit)
        
        image_links = attr[:image][:image_links]
        
        expect(image_links).to have_key(:large_url)
        expect(image_links).to have_key(:large_height)
        expect(image_links).to have_key(:large_width)
        expect(image_links).to have_key(:thumbnail_url)
        expect(image_links).to have_key(:thumbnail_height)
        expect(image_links).to have_key(:thumbnail_width)
  
        credit = attr[:image][:credit]
  
        expect(credit).to have_key(:owner_name)
        expect(credit).to have_key(:license)
        expect(credit).to have_key(:license_url)
        expect(credit).to have_key(:source)
        expect(credit).to have_key(:notice)
        expect(credit).to have_key(:terms_url)
      end
    end
    
    context 'unsuccessful search of background image api' do
      it 'returns a successful status when given invalid location' do
        get api_v1_backgrounds_path(params: { location: 'dfasdfasdfasfsdfas' })
        
        expect(response).to be_successful
      end
      
      it 'returns parsable json data response for background' do
        get api_v1_backgrounds_path(params: { location: 'dfasdfasdfasfsdfas' })
        
        expect(json_parse(response.body)).to be_a(Hash)
      end

      it 'returns correct response attribute fields' do
        get api_v1_backgrounds_path(params: { location: 'dfasdfasdfasfsdfas' })
        hash = json_parse(response.body)
        attr = hash[:data][:attributes]
    
        expect(hash).to have_key(:data)
        expect(hash[:data]).to have_key(:id)
        expect(hash[:data][:id]).to eq(nil)
        expect(hash[:data][:type]).to eq('image')
    
        expect(attr).to have_key(:image)
    
        expect(attr[:image][:image_id]).to be_nil
        expect(attr[:image][:owner_id]).to be_nil
        expect(attr[:image][:secret_id]).to be_nil
        expect(attr[:image][:title]).to eq('NO IMAGE FOUND')
        expect(attr[:image][:location]).to eq('dfasdfasdfasfsdfas')
        expect(attr[:image][:image_links]).to be_nil
        expect(attr[:image][:credit]).to be_nil
        
        expect(attr[:image][:image_links]).to be_nil
        expect(attr[:image][:credit]).to be_nil
      end
    end
  end
end

