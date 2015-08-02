class BooksElasticsearch
  def initialize
    @client = Elasticsearch::Client.new log: true
  end

  def index(book)
    @client.index  index: 'book', type: 'books', id: book.id, body: {
      title: book.title,
      author: book.author
    }
  end

  def search(term)
    results = @client.search index: 'book', type: "books", body: { query:
      {
        bool: {
          should: [
            { match: { title: { query: term, boost: 1.5 } } },
            { match: { author: { query: term, boost: 1 } } }
          ]
        }
      }
    }
    results["hits"]["hits"].map do |result|
      Book.find(result["_id"])
    end
  end
end
