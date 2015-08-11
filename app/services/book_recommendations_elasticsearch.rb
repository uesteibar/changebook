class BookRecommendationsElasticsearch
  def initialize
    @client = ElasticsearchClientAdapter.new("book")
  end

  def recommend(genre_ids: genre_ids, location: location, distance: distance, limit: limit)
    @client.search type: "books", size: limit, body: { query:
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
            field_value_factor: {
              field: "valoration",
              factor: 0.5,
              modifier: "sqrt"
            },
            weight: 0.5
          },
          {
            gauss: {
              locations: {
                origin: location,
                scale: "#{distance}km"
              }
            },
            weight: 2
          }],
          score_mode: "sum"
        }
      }
    }
  end
end
