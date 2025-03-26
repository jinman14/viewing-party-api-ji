class MovieSerializer
  include JSONAPI::Serializer

  set_type :movie
  attributes :id, :title, :vote_average

  attribute :id do |movie|
    movie[:id].to_s
  end
end
