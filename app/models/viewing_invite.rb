class ViewingInvite < ApplicationRecord
  belongs_to :viewing_party
  belongs_to :user
end