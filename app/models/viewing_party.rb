class ViewingParty < ApplicationRecord
  has_many :viewing_invites
  has_many :users, through: :viewing_invites

  def self.create_viewing_party(viewing_party_params)
    start_time = viewing_party_params[:start_time].to_time
    end_time = viewing_party_params[:end_time].to_time
    party_duration = (end_time - start_time) / 60
    movie_runtime = MovieDetails.get_movie_runtime(viewing_party_params[:movie_id])

    # if end_time < start_time
    #   return ErrorMessage "end must be after start"
    # else party_duration < movie_runtime
    #     return ErrorMessage "party duration not long enough"
    # end

    party = ViewingParty.new(
      name: viewing_party_params[:name],
      start_time: viewing_party_params[:start_time],
      end_time: viewing_party_params[:name],
      movie_id: viewing_party_params[:name],
      movie_title: viewing_party_params[:name],
      host_id: viewing_party_params[:name]
    )

    if party.saved?
      
    end
  end
end