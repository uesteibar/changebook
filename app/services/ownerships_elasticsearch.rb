class OwnershipsElasticsearch
  def initialize
    @client = Elasticsearch::Client.new log: true
    @index = "ownership"
    @type = "ownerships"
  end

  def index(ownership)
    @client.index  index: @index, type: @type, id: ownership.id, body: {
      book_title: ownership.book.title,
      book_id: ownership.book.id,
      book_genre_id: ownership.book.genre.id,
      offering: ownership.to_give_away || ownership.to_exchange,
      location: {
        lat: ownership.user.latitude,
        lon: ownership.user.longitude
      }
    }
  end

  def search_offering(lat: lat, lon: lon, distance: 10)
    results = @client.search index: @index, type: @type, body: { query: {
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

  def destroy(book)
    @client.delete index: @index, type: @type, id: book.id
  end
end
