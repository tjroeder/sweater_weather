require 'rails_helper'

RSpec.describe BooksFacade, :vcr, type: :facade do
  let!(:search) { BooksFacade.destination_book_search('denver,co', 2) }

  context 'class methods' do
    describe '::get_destination_book_search' do
      it 'returns a BooksForecast object' do
        expect(search).to be_a(BooksForecast)
      end

      it 'creates a BooksForecast with correct destination' do
        expect(search.destination).to eq('denver,co')
      end

      it 'creates a BooksForecast with valid quantity of books' do
        expect(search.books.count).to eq(2)
      end
    end
  end
end
