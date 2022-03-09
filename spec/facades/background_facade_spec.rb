require 'rails_helper'

RSpec.describe BackgroundFacade, type: :facade do
  let!(:background) { BackgroundFacade.get_location_image('denver,co') }

  context 'class methods', :vcr do
    describe '::get_location_background' do
      it 'returns a single Background object' do
        expect(background).to be_a(Background)
      end

      it 'returns obj with title no image found if no images found' do
        broken =  BackgroundFacade.get_location_image('asdfasdfsdfasdfasdfs')

        expect(broken).to be_a(Background)
        expect(broken.title).to eq('NO IMAGE FOUND')
        expect(broken.image[:title]).to eq('NO IMAGE FOUND')
        expect(broken.image[:location]).to eq('asdfasdfsdfasdfasdfs')
      end
    end
  end
end
