class ViewingPartySerializer
  include JSONAPI::Serializer

  set_type :viewing_party
  attributes :name, :start_time, :end_time, :movie_id, :movie_title

  def self.format_viewing_party_list(viewing_parties)
    { data: viewing_parties.map do |party|
        {
          id: party.id.to_s,
          type: "viewing_party",
          attributes: {
            name: party.name,
            start_time: party.start_time,
            end_time: party.end_time,
            movie_id: party.movie_id,
            movie_title: party.movie_title,
            invitees: party.users.map { |user| 
              {
                id: user.id,
                name: user.name,
                username: user.username
              }
            }
          }
        }
      end
    }
  end
end

