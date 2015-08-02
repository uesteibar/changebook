class BooksElasticsearch
  def initialize
    @client = Elasticsearch::Client.new log: true
    @index = "book"
    @type = "books"
  end

  def index(book)
    @client.index  index: @index, type: @type, id: book.id, body: {
      title: book.title,
      author: book.author,
      genre_id: book.genre.id,
      genre: book.genre.name
    }
  end

  def search(term)
    results = @client.search index: @index, type: @type, body: { query:
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
