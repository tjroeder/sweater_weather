require 'rails_helper'

RSpec.describe BackgroundFacade, type: :facade do
  let!(:background) { BackgroundFacade.get_location_image('denver,co') }

  context 'class methods', :vcr do
    describe '::get_location_background' do
      it 'returns a single Background object' do
        expect(background).to be_a(Background)
      end
    end
  end
end
