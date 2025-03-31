require "rails_helper"

RSpec.describe "Viewing Party", type: :request do
  describe "Create Viewing Party Endpoint" do
    before(:all) do
        User.destroy_all
        @danny = User.create!(name: "Danny DeVito", username: "danny_de_v", password: "yayjoe")
        @dolly = User.create!(name: "Dolly Parton", username: "dollyP", password: "wollydolly")
        @lionel = User.create!(name: "Lionel Messi", username: "futbol_geek", password: "yugioh")
    end

    let(:viewing_party_params) do
      {
        name: "Story Time",
        start_time: "2025-02-01 10:00:00",
        end_time: "2025-02-01 14:30:00",
        movie_id: 122,
        movie_title: "The Lord of the Rings: The Return of the King",
        host_id: @danny.id,
        # invitees: [@danny.id, @dolly.id, @lionel.id ]
      }
    end

    # let(:invitees) { [1,2,3] }

    context "request is valid" do
      it "returns expected fields" do
        post api_v1_viewing_parties_path, params: { viewing_party: viewing_party_params, invitees: [@danny.id, @dolly.id, @lionel.id ] }, as: :json

        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body, symbolize_names: true)
        # binding.pry
        expect(json[:data][0][:type]).to eq("viewing_party")
        expect(json[:data][0][:id]).to eq(ViewingParty.last.id.to_s)
        expect(json[:data][0][:attributes][:name]).to eq(viewing_party_params[:name])
        expect(json[:data][0][:attributes][:start_time]).to eq("2025-02-01T10:00:00.000Z")
        expect(json[:data][0][:attributes][:end_time]).to eq("2025-02-01T14:30:00.000Z")
        expect(json[:data][0][:attributes][:movie_id]).to eq(viewing_party_params[:movie_id])
        expect(json[:data][0][:attributes][:movie_title]).to eq(viewing_party_params[:movie_title])
        expect(json[:data][0][:attributes][:invitees]).to eq(
          [{:id=>@danny.id, :name=>"Danny DeVito", :username=>"danny_de_v"},
            {:id=>@dolly.id, :name=>"Dolly Parton", :username=>"dollyP"},
            {:id=>@lionel.id, :name=>"Lionel Messi", :username=>"futbol_geek"}])
      end
    end
  end
end
# expect(json[:data][0][:attributes][:invitees]).to match_array([
#   { id: 1, name: "Danny DeVito", username: "danny_de_v" },
#   { id: 2, name: "Dolly Parton", username: "dollyP" },
#   { id: 3, name: "Lionel Messi", username: "futbol_geek" }
# ])
# "start_time": "2025-02-01 10:00:00",
#   "end_time": "2025-02-01 14:30:00",
#   "movie_id": 278,
#   "movie_title": "The Shawshank Redemption",
#   "invitees": [1, 2, 3]