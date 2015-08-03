class BookRecommendationsElasticsearch
  def initialize
    @client = Elasticsearch::Client.new log: true
  end
  def recommend(genre_ids: genre_ids, location: location, distance: distance)ç
    @client.search index: "book", type: "books", body: { query:
      {
        function_score: {
        query: {
          match_all: {}
        },
        functions: [
          {
            filter: {
              terms: {
                genre_id: genre_ids
              }
            },
            weight: 1.5
          }
        ]
      }
      }
    }
  end
end
