class BookRecommendationsElasticsearch
  def initialize
    @client = Elasticsearch::Client.new log: true
  end
  def recommend(genre_ids: genre_ids, location: location, distance: distance, limit: limit)
    @client.search index: "book", type: "books", size: limit, body: { query:
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
          },
          {
            filter: {
                geo_distance: {
                    distance: "#{distance}km",
                    locations: location
                }
            },
            weight: 2
          }
        ]
      }
      }
    }
  end
end
