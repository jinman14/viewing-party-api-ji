class UserSerializer
  include JSONAPI::Serializer
  attributes :name, :username, :api_key

  def self.format_user_list(users)
    { data:
      users.map do |user|
        {
          id: user.id.to_s,
          type: "user",
          attributes: {
              name: user.name,
              username: user.username
            }
        }
      end
    }
  end

  def self.format_user_detailed(user)
    { data: 
      {
        id: user.id.to_s,
        type: "user",
        attributes: {
          name: user.name,
          user_name: user.username,
          viewing_parties_hosted: hosted_parties(user),
          viewing_parties_invited: parties_invited_to(user)
        }
      }
    }
  end

  private

  def self.hosted_parties(user)
    hosted_parties = ViewingParty.where(host_id: user.id)

    hosted_parties.map do |party|
      {
        id: party.id,
        name: party.name,
        start_time: party.start_time,
        end_time: party.end_time,
        movie_title: party.movie_title,
        host_id: party.host_id
      }
    end
  end

  def self.parties_invited_to(user)
    invited_parties = ViewingParty.joins(:viewing_invites).where('viewing_invites.user_id = ?', user.id)

    invited_parties.map do |party|
      {
        id: party.id,
        name: party.name,
        start_time: party.start_time,
        end_time: party.end_time,
        movie_title: party.movie_title,
        host_id: party.host_id
      }
    end
  end
end