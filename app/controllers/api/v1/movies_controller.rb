class Api::V1::MoviesController < ApplicationController
  def index
    conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.headers["Authorization"] = "Bearer #{Rails.application.credentials.tmdb[:read_access_token]}"
      faraday.headers["Accept"] = 'application/json'
    end
    Rails.logger.debug "TMDB API Key: #{Rails.application.credentials.tmdb[:read_access_token]}"

    if params[:query].present?
      response = conn.get("/3/search/movie", { query: params[:query] })
    else
      response = conn.get("/3/movie/top_rated")
    end

    json = JSON.parse(response.body, symbolize_names: true)

    Rails.logger.debug "TMDb Response: #{json[:results]}"
    if response.success?
      top20 = json[:results].first(20)
      render json: MovieSerializer.format_movie_list(top20)
    else
      render json: { error: "Failed to get the movies" }, status: :bad_request
    end
  end

  # def show
  #   query = params[:query]
  #   # page = params[:page] || 1

  #   conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
  #     faraday.headers["Authorization"] = "Bearer #{Rails.application.credentials.tmdb[:read_access_token]}"
  #   end
  #   Rails.logger.debug "TMDB API Key: #{Rails.application.credentials.tmdb[:read_access_token]}"

  #   response = conn.get("/3/search/movie", { query: query })#, page: page })

  #   json = JSON.parse(response.body, symbolize_names: true)

  #   Rails.logger.debug "TMDb Response: #{json}"

  #   render json: json
  #   # if response.success?
  #   #   json = JSON.parse(response.body, symbolize_names: true)
  #   #   Rails.logger.debug "TMDb Response: #{json}"
  #   #   render json: MovieSerializer.new(json[:results]).serializable_hash
  #   # else
  #   #   Rails.logger.error "Error fetching data from TMDB: #{response.status}"
  #   #   render json: { error: "Unable to fetch movies" }, status: :bad_request
  #   # end
  # end
end