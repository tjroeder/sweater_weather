require 'rails_helper'

RSpec.describe BooksForecast, :vcr, type: :poro do
  let!(:denver) { ForecastService.get_forecast(39.738453, -104.984853, 'imperial') }
  let!(:forecast) { Forecast.new(denver) }
  let!(:book_data) { 
                     {
                       numFound: 41867,
                       start: 0,
                       numFoundExact: true,
                       docs: [
                               {
                                 key: "/works/OL8503198W",
                                 type: "work",
                                 seed: [
                                     "/books/OL10909613M",
                                     "/works/OL8503198W",
                                     "/authors/OL2843451A"
                                 ],
                                 title: "Denver, Co",
                                 title_suggest: "Denver, Co",
                                 has_fulltext: false,
                                 edition_count: 1,
                                 edition_key: [
                                     "OL10909613M"
                                 ],
                                 publish_date: [
                                     "January 2001"
                                 ],
                                 publish_year: [
                                     2001
                                 ],
                                 first_publish_year: 2001,
                                 isbn: [
                                     "9780762507849",
                                     "0762507845"
                                 ],
                                 last_modified_i: 1338943517,
                                 ebook_count_i: 0,
                                 publisher: [
                                     "Universal Map Enterprises"
                                 ],
                                 language: [
                                     "eng"
                                 ],
                                 author_key: [
                                     "OL2843451A"
                                 ],
                                 author_name: [
                                     "Universal Map"
                                 ],
                                 publisher_facet: [
                                     "Universal Map Enterprises"
                                 ],
                                 _version_: 1715096877364412420,
                                 author_facet: [
                                     "OL2843451A Universal Map"
                                 ]
                               },
                               {
                                 key: "/works/OL19500062W",
                                 type: "work",
                                 seed: [
                                     "/books/OL2061373M",
                                     "/works/OL19500062W",
                                     "/subjects/photovoltaic_cells",
                                     "/subjects/safety_measures",
                                     "/subjects/solar_cells",
                                     "/subjects/congresses",
                                     "/subjects/design_and_construction",
                                     "/authors/OL714790A"
                                 ],
                                 title: "Photovoltaic safety, Denver, CO, 1988",
                                 title_suggest: "Photovoltaic safety, Denver, CO, 1988",
                                 has_fulltext: false,
                                 edition_count: 1,
                                 edition_key: [
                                     "OL2061373M"
                                 ],
                                 publish_date: [
                                     "1988"
                                 ],
                                 publish_year: [
                                     1988
                                 ],
                                 first_publish_year: 1988,
                                 number_of_pages_median: 246,
                                 lccn: [
                                     "88042854"
                                 ],
                                 publish_place: [
                                     "New York"
                                 ],
                                 contributor: [
                                     "Luft, Werner.",
                                     "Photovoltaics Safety Conference (2nd : 1988 : Denver, Colo.)",
                                     "Solar Energy Research Institute."
                                 ],
                                 lcc: [
                                     "TK-8322.00000000.P46 1988"
                                 ],
                                 ddc: [
                                     "621.31244"
                                 ],
                                 isbn: [
                                     "0883183668",
                                     "9780883183663"
                                 ],
                                 last_modified_i: 1604827192,
                                 ebook_count_i: 0,
                                 cover_edition_key: "OL2061373M",
                                 cover_i: 4745684,
                                 publisher: [
                                     "American Institute of Physics"
                                 ],
                                 language: [
                                     "eng"
                                 ],
                                 author_key: [
                                     "OL714790A"
                                 ],
                                 author_name: [
                                     "Werner Luft"
                                 ],
                                 subject: [
                                     "Photovoltaic cells",
                                     "Safety measures",
                                     "Solar cells",
                                     "Congresses",
                                     "Design and construction"
                                 ],
                                 id_goodreads: [
                                     "3793862"
                                 ],
                                 publisher_facet: [
                                     "American Institute of Physics"
                                 ],
                                 subject_facet: [
                                     "Congresses",
                                     "Design and construction",
                                     "Photovoltaic cells",
                                     "Safety measures",
                                     "Solar cells"
                                 ],
                                 _version_: 1715082851837280256,
                                 lcc_sort: "TK-8322.00000000.P46 1988",
                                 author_facet: [
                                     "OL714790A Werner Luft"
                                 ],
                                 subject_key: [
                                     "congresses",
                                     "design_and_construction",
                                     "photovoltaic_cells",
                                     "safety_measures",
                                     "solar_cells"
                                 ],
                                 ddc_sort: "621.31244"
                               }
                             ]
                     }
                   }
  
  let!(:books_forecast) { BooksForecast.new(destination, book_data, forecast)}
  context 'object properties' do
    it 'exists' do
      expect(books_forecast).to be_a(BooksForecast)
    end

    it 'has attributes' do
      expect(books_forecast).to have_attributes(destination: 'denver,co')

      expected_forecast = {
        summary:
        temperature: 
      }
      expect(books_forecast).to have_attributes(forecast: )

      expect(books_forecast).to have_attributes(total_books_found: 41867)
      expect(books).to have_key(:books)
      expect(books.count).to eq(2)
      expect(books.first).to be_a(Book)
      # expect(book).to have_attributes(isbn: ['9780762507849', '0762507845'])
      # expect(book).to have_attributes(title: 'Denver, Co')
      # expect(book).to have_attributes(publisher: ['Universal Map Enterprises'])
    end

    it 'has correct attribute data types' do
      # expect(book.isbn).to be_a(Array)
      # expect(book.isbn.first).to be_a(String)
      # expect(book.isbn.last).to be_a(String)
      # expect(book.title).to be_a(String)
      # expect(book.publisher).to be_a(Array)
      # expect(book.publisher.first).to be_a(String)
      # expect(book.publisher.last).to be_a(String)
    end
  end
end