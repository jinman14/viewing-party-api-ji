class MovieSerializer
  include JSONAPI::Serializer

  set_type :movie
  attributes :title, :vote_average

  def self.format_movie_list(movies)
    { data:
        movies.map do |movie|
          {
            id: movie[:id],
            type: "movie",
            attributes: {
              title: movie[:title],
              vote_average: movie[:vote_average]
            }
          }
        end
    }
  end

  attributes :id, :title, :release_year, :vote_average, :runtime, :genres, :summary, :cast, :total_reviews, :reviews

  def id
    object.id
  end
  
  def release_year
    object.release_year
  end

  def vote_average
    object.vote_average
  end

  def runtime
    object.runtime
  end

  def genres
    object.genres
  end

  def summary
    object.summary
  end

  def cast
    object.cast
  end

  def total_reviews
    object.total_reviews
  end

  def reviews
    object.reviews
  end
end
