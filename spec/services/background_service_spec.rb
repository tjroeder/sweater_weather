require 'rails_helper'

RSpec.describe BackgroundService, type: :service do
  context 'class methods', :vcr do
    describe '::get_background' do
      it 'returns a response hash' do
        photo = BackgroundService.get_background('denver co evening snow')

        expect(photo).to be_a(Hash)
      end
    end
  end
end
