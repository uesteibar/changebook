class BookRecommendations
  def initialize(recommendation_provider = BookRecommendationsElasticsearch.new)
    @recommendation_provider = recommendation_provider
  end

  def generate(user: user, distance: 30, limit: 10)
    results = @recommendation_provider.recommend(
      genre_ids: user.liked_genres.map { |liked_genre| liked_genre.genre_id },
      location: {lat: user.latitude, lon: user.longitude},
      distance: distance,
      limit: limit
    )
    debugger
    results["hits"]["hits"].map do |result|
      Book.find(result["_id"])
    end
  end
end
