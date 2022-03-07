class BookService < ApplicationService
  def self.get_destination_books(destination, quantity)
    url = 'https://openlibrary.org/'
    response = conn(url).get('search.json') do |req|
      req.params['q'] = destination
      req.params['limit'] = quantity
    end

    json_parse(response.body)
  end
end
