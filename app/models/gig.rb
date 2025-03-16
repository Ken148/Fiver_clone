class Gig < ApplicationRecord
  belongs_to :seller_profile  # Each gig belongs to a seller profile
  
  has_many :posts  # Assuming that a gig has many posts associated with it
  
  has_one_attached :basic_image
  has_one_attached :standard_image
  has_one_attached :premium_image

  validates :basic_price, :standard_price, :premium_price, presence: true
  # Add any other validations you need
end
