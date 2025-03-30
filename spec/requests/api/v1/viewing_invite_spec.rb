require "rails_helper"

RSpec.describe "Viewing Invite", type: :request do
  describe "Create Invite to add invitee to Viewing Party" do
    before(:each) do
      @danny = User.create(id: 1, name: "Danny DeVito", username: "danny_de_v")
      @dolly = User.create(id: 2, name: "Dolly Parton", username: "dollyP")
      @lionel = User.create(id: 3, name: "Lionel Messi", username: "futbol_geek")
      @jacob = User.create(id: 4, name: "Jacob Jacob", username: "jacobsquared")

      @party_time = ViewingParty.create(
        name: "super fun test party",
        start_time: "2025-04-01 18:00:00",
        end_time: "2025-04-01 21:00:00",
        movie_id: 122,
        movie_title: "The Lord of the Rings: The Return of the King",
        # host_id: @danny.id
      )
    end

    let(:viewing_invite_params) do
      {
        invitee_user_id: @jacob.id
      }
    end

    context "request is valid" do
      it "returns updated viewing party json" do
        post "/api/v1/viewing_parties/#{@party_time.id}/viewing_invites", params: { viewing_invite: viewing_invite_params }
        
        puts response.body 
        
        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body, symbolize_names: true)

        expect(json["data"][0]["attributes"]["invitees"].length).to eq(4)
        expect(json['data'][0]['attributes']['invitees'].last['id']).to eq(@jacob.id)
        expect(json['data'][0]['attributes']['invitees'].last['name']).to eq(@jacob.name)
        expect(json['data'][0]['attributes']['invitees'].last['username']).to eq(@jacob.username)
      end
    end
  end
end