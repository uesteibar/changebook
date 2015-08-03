class BookRecommendations
  def initialize(recommendation_provider = BookRecommendationsElasticsearch.new)
    @recommendation_provider = recommendation_provider
  end

  def generate(user: user, distance: 30)
    recommendation_provider.recommend(
      genre_ids: user.liked_genres.map { |genre| genre.id },
      location: [user.lat, user.lon],
      distance: distance
    )
  end
end
