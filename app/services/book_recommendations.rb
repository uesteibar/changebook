class BookRecommendations
  def initialize(recommendation_provider = BookRecommendationsElasticsearch.new)
    @recommendation_provider = recommendation_provider
  end

  def generate(user: user, distance: 30, limit: 10)
    @recommendation_provider.recommend(
      genre_ids: user.liked_genres.map { |liked_genre| liked_genre.genre_id },
      location: [user.latitude, user.longitude],
      distance: distance,
      limit: limit
    )
  end
end
