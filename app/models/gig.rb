class Gig < ApplicationRecord
  belongs_to :seller_profile
  has_many :posts
  validates :title, :description, :price, presence: true
end
