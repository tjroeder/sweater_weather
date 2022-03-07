require 'rails_helper'

RSpec.describe 'Books Request API', :vcr, type: :request do
  context '#index action' do
    it 'returns a successful status when given valid location and quantity' do
      get api_v1_book_search_path(params: { location: 'denver,co', quantity: 2 })

      expect(response).to be_successful
    end
    
    it 'returns bad request if given invalid quantity' do
      get api_v1_book_search_path(params: { location: 'denver,co', quantity: -1 })

      expect(response.status).to eq(400)
    end

    it 'returns error message if given invalid quantity' do
      get api_v1_book_search_path(params: { location: 'denver,co', quantity: -1 })
      expected_error =     {
                             errors: [
                               status: 400,
                               detail: 'Incorrect quantity given, must be greater than 0' 
                             ]
                           }

      expect(json_parse(response.body)).to eq(expected_error)
    end
    
    it 'returns parsable json data response for book search' do
      get api_v1_book_search_path(params: { location: 'denver,co', quantity: 2 })
      
      expect(json_parse(response.body)).to be_a(Hash)
    end
    
    it 'returns correct response attribute fields' do
      get api_v1_book_search_path(params: { location: 'denver,co', quantity: 2 })
      hash = json_parse(response.body)
      attr = hash[:data][:attributes]

      expect(hash).to have_key(:data)
      expect(hash[:data]).to have_key(:id)
      expect(hash[:data]).to have_key(:type)
      expect(hash[:data][:id]).to eq(nil)
      expect(hash[:data]).to have_key(:attributes)

      expect(attr).to have_key(:destination)
      expect(attr).to have_key(:forecast)
      expect(attr).to have_key(:total_books_found)
      expect(attr).to have_key(:books)

      expect(attr[:destination]).to be_a(String)
      expect(attr[:destination]).to eq('denver,co')

      expect(attr[:forecast]).to be_a(Hash)
      expect(attr[:forecast].count).to eq(2)
      expect(attr[:forecast][:summary]).to eq('snow')
      expect(attr[:forecast][:temperature]).to eq('27 F')

      expect(attr[:total_books_found]).to be_a(Integer)
      expect(attr[:total_books_found]).to eq(41867)

      expect(attr[:books]).to be_a(Array)
      expect(attr[:books].count).to eq(2)
      expect(attr[:books].first).to be_a(Hash)
      expect(attr[:books].first).to have_key(:isbn)
      expect(attr[:books].first).to have_key(:title)
      expect(attr[:books].first).to have_key(:publisher)
      expect(attr[:books].first[:isbn]).to eq(["9780762507849", "0762507845"])
      expect(attr[:books].first[:title]).to eq("Denver, Co")
      expect(attr[:books].first[:publisher]).to eq(["Universal Map Enterprises"])

      expect(attr[:books].last).to be_a(Hash)
      expect(attr[:books].last).to have_key(:isbn)
      expect(attr[:books].last).to have_key(:title)
      expect(attr[:books].last).to have_key(:publisher)
      expect(attr[:books].last[:isbn]).to eq(["0883183668", "9780883183663"])
      expect(attr[:books].last[:title]).to eq("Photovoltaic safety, Denver, CO, 1988")
      expect(attr[:books].last[:publisher]).to eq(["American Institute of Physics"])
    end
  end
end