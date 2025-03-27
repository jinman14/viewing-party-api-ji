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
end