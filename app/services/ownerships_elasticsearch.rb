class OwnershipsElasticsearch
  def initialize
    @client = Elasticsearch::Client.new log: true
  end

  def index(ownership)
    debugger
    @client.index  index: 'ownership', type: 'ownerships', id: ownership.id, body: {
      book_title: ownership.book.title,
      book_id: ownership.book.id,
      offering: ownership.to_give_away || ownership.to_exchange,
      location: {
        lat: ownership.user.latitude,
        lon: ownership.user.longitude
      }
    }
  end

  def search_offering(lat: lat, lon: lon, distance: 10)
    results = @client.search index: 'ownership', type: "ownerships", body: { query: {
        filtered: {
          query: {
            term: {
              offering: true
            }
          },
          filter: {
            geo_distance: {
              distance: "#{distance}km",
              distance_type: "plane",
              location: {
                lat: lat,
                lon: lon
              }
            }
          }
        }
      }
    }
    results["hits"]["hits"].map do |result|
      Ownership.find(result["_id"])
    end
  end
end
