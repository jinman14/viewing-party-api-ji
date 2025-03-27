class MovieGateway
  def self.fetch_movies(params = {})
    if params.present? && params[:query].present?
      response = conn.get("/3/search/movie") do |required|
        required.params['query'] = params[:query]
        required.params['language'] = 'en-US'
      end
    else
      response = conn.get("/3/movie/top_rated")
    end
    # Rails.logger.debug "TMDB Raw: #{response.body}"
    json = JSON.parse(response.body, symbolize_names: true)
    # Rails.logger.debug "TMDb Parsed: #{json[:results]}"
    json[:results]
  end

  private

  def self.conn
    Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.headers["Authorization"] = "Bearer #{Rails.application.credentials.tmdb[:read_access_token]}"
      faraday.headers["Accept"] = 'application/json'
    end
  end
end


