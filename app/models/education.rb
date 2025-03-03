class Education < ApplicationRecord
  belongs_to :seller_profile  # Link to SellerProfile
  validates :degree, :school_name, :graduation_year, presence: true
end
