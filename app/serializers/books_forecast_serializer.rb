class BooksForecastSerializer
  include JSONAPI::Serializer
  
  set_id :id
  set_type :books

  attributes :destination,
             :forecast,
             :total_books_found,
             :books
end