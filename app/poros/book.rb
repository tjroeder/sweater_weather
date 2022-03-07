class Book
  attr_reader :isbn,
              :title,
              :publisher

  def initialize(data)
    @isbn = data[:isbn]
    @title = data[:title]
    @publisher = data[:publisher]
  end
end