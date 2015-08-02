class BooksElasticsearch
  def initialize
    @client = Elasticsearch::Client.new log: true
  end

  def index(book)
    @client.index  index: 'book', type: 'books', id: book.id, body: { title: book.title, author: book.author }
  end

  def search(term)
    results = @client.search index: 'book', body: { query:
      {
        bool: {
          should: [
            { match: { title: term } },
            { match: { author: term } }
          ]
        }
      }
    }
    results["hits"]["hits"].map do |result|
      Book.find(result["_id"])
    end
  end
end
