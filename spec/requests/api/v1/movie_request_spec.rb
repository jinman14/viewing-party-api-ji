require "rails_helper"

RSpec.describe "Movies API Endpoints", type: :request do
  describe "happy path" do
    it "can retrieve a list of movies" do
      json_response = File.read('spec/fixtures/movie_top_rated_query.json')

      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated").
      with(
        headers: {
        'Accept'=>'application/json',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Authorization'=>'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MDJiMTMyZWYzMmNlM2Q4ZTJjNzIyN2E0OGQxNmIyZSIsIm5iZiI6MTc0Mjk0NTQ4Ni4zMjUsInN1YiI6IjY3ZTMzY2NlN2I3MzEzYjVhZWYwOGViNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.KtcPqZylsno9_5uN7K2SzsgnTFV_guyMQwpX3bZKtp8',
        'User-Agent'=>'Faraday v2.10.1'
        }).
      to_return(status: 200, body: json_response, headers: {})

      get "/api/v1/movies"

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data].first[:id]).to be_an(Integer)
      expect(json[:data].first[:type]).to eq("movie")
      expect(json[:data].first[:attributes][:title]).to eq("The Shawshank Redemption")
      expect(json[:data].first[:attributes][:vote_average]).to eq(8.709)
    end
  end
end
# describe "Show Movie Endpoint with details" do
#   let(:movie_id) { 122 }
#   let(:movie_data) do
#     {
#       adult: false,
#       backdrop_path: "/2u7zbn8EudG6kLlBzUYqP8RyFU4.jpg",
#       belongs_to_collection: { id: 119, name: "The Lord of the Rings Collection" },
#       budget: 94000000,
#       genres: [{ id: 12, name: "Adventure" }, { id: 14, name: "Fantasy" }],
#       homepage: "http://www.lordoftherings.net",
#       id: 122,
#       release_date: "2003-12-17", 
#       title: "The Lord of the Rings: The Return of the King",
#       overview: "As armies mass for a final battle that will decide the fate of the world..."
#     }
#   end

#   before do
#     stub_request(:get, "https://api.themoviedb.org/3/movie/#{movie_id}")
#       .to_return(status: 200, body: movie_data.to_json, headers: { 'Content-Type' => 'application/json'})
#   end

#   it "can show a single movie by id and desired details about it" do
#     get "/movies/#{movie_id}" 

#     expect(response).to have_http_status(:ok)
#     json = JSON.parse(response.body, symbolize_names: true)
#     expect(json[:data][:type]).to eq("movie")
#     expect(json[:data][:attributes][:title]).to eq("The Lord of the Rings: The Return of the King")
#     expect(json[:data][:attributes][:release_year]).to eq(2003)
#   end
# end