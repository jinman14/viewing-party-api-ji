require "rails_helper"

RSpec.describe ViewingParty, type: :model do
  describe "relationships" do
    it { should have_many(:viewing_invites) }
    it { should have_many(:users).through(:viewing_invites) }
  end
end