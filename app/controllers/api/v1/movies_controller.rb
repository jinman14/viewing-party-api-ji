class Api::V1::MoviesController < ApplicationController
  def index
    movies = MovieGateway.fetch_movies(query: params[:query])
    # Rails.logger.debug "RENDERED JSON COMING THROUGH: #{movies}"
    if movies.present?
      top20 = movies.first(20)
      render json: MovieSerializer.format_movie_list(top20)
    else
      render json: { error: "Failed to get the movies" }, status: :bad_request
    end
  end

  def show
    movie_id = params[:id]

    movie_data = MovieGateway.fetch_movie_details(movie_id)

    if movie_data
      movie_details = MovieDetails.new(movie_data)

      render json: MovieSerializer.new(movie_details).serializable_hash
    else
      render json: { error: "Uh oh! We don't know a movie by that id number" }, status: :not_found
    end
  end
end