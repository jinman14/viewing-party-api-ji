class Api::V1::ViewingPartiesController < ApplicationController
  def create
    party = ViewingParty.create(viewing_party_params)

    if party.persisted?
      # Create invites for each user in the invitees list
      params[:invitees].each do |user_id|
        # binding.pry
        ViewingInvite.create(viewing_party: party, user_id: user_id)
      end

      render json: ViewingPartySerializer.format_viewing_party_list([party]), status: :created
    else
      render json: { errors: party.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def viewing_party_params
    params.require(:viewing_party).permit(:name, :start_time, :end_time, :movie_id, :movie_title, :host_id)
  end

  def invitees
    params[:invitees] || []
  end
end