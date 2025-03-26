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
end
