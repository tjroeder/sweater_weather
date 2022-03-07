require 'rails_helper'

RSpec.describe Book, type: :poro do
  let!(:book_data) { 
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
                     }
                   }
  let!(:book) { Book.new(book_data)}

  context 'object properties' do
    it 'exists' do
      expect(book).to be_a(Book)
    end

    it 'has attributes' do
      expect(book).to have_attributes(isbn: ['9780762507849', '0762507845'])
      expect(book).to have_attributes(title: 'Denver, Co')
      expect(book).to have_attributes(publisher: ['Universal Map Enterprises'])
    end

    it 'has correct attribute data types' do
      expect(book.isbn).to be_a(Array)
      expect(book.isbn.first).to be_a(String)
      expect(book.isbn.last).to be_a(String)
      expect(book.title).to be_a(String)
      expect(book.publisher).to be_a(Array)
      expect(book.publisher.first).to be_a(String)
      expect(book.publisher.last).to be_a(String)
    end
  end
end