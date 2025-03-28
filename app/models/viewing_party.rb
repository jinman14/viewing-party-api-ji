class ViewingParty < ApplicationRecord
  belongs_to :movie
  has_many :viewing_invites
  has_many :users, through: :viewing_invites
end