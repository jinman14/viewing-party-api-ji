class ViewingParty < ApplicationRecord
  has_many :viewing_invites
  has_many :users, through: :viewing_invites
  has_many :invitees, through: :viewing_invites, source: :user

  validates :name, :start_time, :end_time, :movie_id, :movie_title, :host_id, presence: true
  # validate :party_duration_is_valid

  def movie_runtime_in_minutes
    movie = MovieGateway.fetch_movie_details(movie_id)
    movie[:runtime] if movie
  end

  private

  def party_duration_is_valid

    movie_runtime_in_minutes = movie_runtime_in_minutes

      if movie_runtime_in_minutes.nil?
        errors.add(:end_time, "viewing party must be at least #{movie_runtime_in_minutes} long")
      else
        errors.add(:movie_id, "could not fetch movie runtime.")
      end

      if end_time && start_time && end_time < start_time
        errors.add(:end_time, "Calm yourself, Time Traveler. This time does not come after the start time.")
      end
  end
  # def self.create_viewing_party(viewing_party_params)
  #   start_time = viewing_party_params[:start_time].to_time
  #   end_time = viewing_party_params[:end_time].to_time
  #   party_duration = (end_time - start_time) / 60
  #   movie_runtime = MovieDetails.get_movie_runtime(viewing_party_params[:movie_id])

  #   # if end_time < start_time
  #   #   return ErrorMessage "end must be after start"
  #   # else party_duration < movie_runtime
  #   #     return ErrorMessage "party duration not long enough"
  #   # end

  #   party = ViewingParty.new(
  #     name: viewing_party_params[:name],
  #     start_time: viewing_party_params[:start_time],
  #     end_time: viewing_party_params[:name],
  #     movie_id: viewing_party_params[:name],
  #     movie_title: viewing_party_params[:name],
  #     host_id: viewing_party_params[:name]
  #   )

  #   if party.saved?
      
  #   end
  # end
end