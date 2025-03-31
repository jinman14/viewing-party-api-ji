class MovieDetails
  attr_reader :movie_data

  def initialize(movie_data)
    @movie_data = movie_data
  end

  def id
    movie_data[:id]
  end

  def title
    movie_data[:title]
  end

  def release_year
    if movie_data[:release_date].present? 
      year = movie_data[:release_date].split('-')[0].to_i
    else
      year = nil
    end
    year
  end

  def vote_average
    movie_data[:vote_average]
  end

  def runtime
    hours = (movie_data[:runtime] / 60).to_i
    minutes = movie_data[:runtime] % 60
    "#{hours} hours, #{minutes} minutes"
  end

  def genres
    movie_data[:genres].map { |genre| genre[:name] }
  end

  def summary
    movie_data[:overview]
  end

  def cast
    cast_data = MovieGateway.fetch_movie_cast(movie_data[:id])
    # binding.pry
    cast_data.take(10).map do |member|
      { character: member[:character], actor: member[:name] }
    end
  end

  def total_reviews
    reviews_data = MovieGateway.fetch_movie_reviews(movie_data[:id])
# binding.pry
    reviews_data.length
  end

  def reviews
    reviews_data = MovieGateway.fetch_movie_reviews(movie_data[:id])

    reviews_data.take(5).map do |review|
      { 
        author: review[:author], 
        review: review[:content] 
      }
    end
  end
end
# def self.get_movie_runtime(movie_id)
#   response = conn.get("/3/movie/#{movie_id}")

#   json = JSON.parse(response.body, symbolize_names: :true)
#   runtime = json[:runtime]
#   return runtime
# end

# private

# def self.conn
#   Faraday.new(url: "https://api.themoviedb.org") do |faraday|
#     faraday.headers["Authorization"] = "Bearer #{Rails.application.credentials.tmdb[:read_access_token]}"
#     faraday.headers["Accept"] = 'application/json'
#   end
# end