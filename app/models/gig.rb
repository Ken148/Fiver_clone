class Gig < ApplicationRecord
  belongs_to :user
  has_one :seller_profile, through: :user
end
