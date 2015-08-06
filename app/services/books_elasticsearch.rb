class BooksElasticsearch
  def initialize
    if ENV['SEARCHBOX_SSL_URL']
      @client = Elasticsearch::Client.new host: ENV['SEARCHBOX_SSL_URL']
    else
      @client = Elasticsearch::Client.new log: true
    end
    @index = "book"
    @type = "books"
  end

  def index(book)
    @client.index  index: @index, type: @type, id: book.id, body: {
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
    results = @client.search index: @index, type: @type, size: limit, body: { query:
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
    results["hits"]["hits"].map do |result|
      Book.find(result["_id"])
    end
  end

  def destroy(book)
    @client.delete index: @index, type: @type, id: book.id
  end
end
