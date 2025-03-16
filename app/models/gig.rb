class Gig < ApplicationRecord
  belongs_to :seller_profile  # Ensures that each gig is associated with one seller profile

  # Optional: Additional fields and validation for the Gig model
  validates :title, :description, :price, presence: true  # Example validations for gig details
end
