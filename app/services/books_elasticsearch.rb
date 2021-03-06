class BooksElasticsearch
  def initialize
    @client = ElasticsearchClientAdapter.new("book")
    @type = "books"
  end

  def index(book)
    @client.index type: @type, id: book.id, body: {
      title: book.title,
      author: book.author,
      genre_id: book.genre.id,
      genre: book.genre.name,
      valoration: book.valoration,
      locations: book.offerings.map { |ownership| {
        lat: ownership.user.latitude || 0,
        lon: ownership.user.longitude || 0} }
    }
  end

  def search(term, limit = 10)
    results = @client.search type: @type, size: limit, body: { query:
      {
        bool: {
          should: [
            { match: { title: { query: term, boost: 1.5 } } },
            { match: { genre: { query: term, boost: 1.25 } } },
            { match: { author: { query: term, boost: 1 } } }
          ]
        }
      }
    }

    ids = results["hits"]["hits"].map { |hit| hit["_id"] }
    Book.find(ids)
  end

  def destroy(book)
    @client.delete index: @index, type: @type, id: book.id
  end
end
