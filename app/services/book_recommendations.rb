class BookRecommendations
  def initialize(recommendation_provider = BookRecommendationsElasticsearch.new)
    @recommendation_provider = recommendation_provider
  end

  def generate(user: user, distance: 30, limit: 10)
    results = @recommendation_provider.recommend(
      genre_ids: user.liked_genres.map { |liked_genre| liked_genre.genre_id },
      location: {lat: user.latitude || 0, lon: user.longitude || 0},
      distance: distance,
      limit: limit
    )

    results["hits"]["hits"].map do |result|
      Book.find(result["_id"])
    end
  end
end
