class MovieDetails
  def self.get_movie_runtime(movie_id)
    response = conn.get("/3/movie/#{movie_id}")

    json = JSON.parse(response.body, symbolize_names: :true)
    runtime = json[:runtime]
    return runtime
  end

  private

  def self.conn
    Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.headers["Authorization"] = "Bearer #{Rails.application.credentials.tmdb[:read_access_token]}"
      faraday.headers["Accept"] = 'application/json'
    end
  end
end