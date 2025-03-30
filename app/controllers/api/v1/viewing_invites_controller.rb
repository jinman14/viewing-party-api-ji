class Api::V1::ViewingInvitesController < ApplicationController
  
  def create
    party = ViewingParty.find(params[:viewing_party_id])

    user = User.find_by(id: viewing_invite_params[:invitee_user_id])

    if user.nil?
      return render json: { error: "User not found" }, status: :not_found
    end

    invite = ViewingInvite.create(viewing_party: party, user: user)

    if invite.persisted?
      # render json: { message: "The invite is in the mail!" }, status: :created
      render json: ViewingPartySerializer.format_viewing_party_list([party]), status: :created
    else
      render json: {errors: invite.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def viewing_invite_params
    params.permit(:invitee_user_id)
  end
end