require 'rails_helper'

RSpec.describe BookService, type: :service do
  context 'class methods', :vcr do
    describe '::get_destination_books' do
      it 'returns a response hash' do
        books = BookService.get_destination_books('denver,co')

        expect(books).to be_a(Hash)
      end
    end
  end
end
