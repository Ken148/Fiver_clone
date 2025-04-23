class Service < ApplicationRecord
  # Service belongs to a post (category)
  belongs_to :post

  # Validations to ensure each service has a name, description, and price
  validates :name, :description, :price, presence: true

  # Optional: Attach an image to the service (using Active Storage)
  has_one_attached :image

  # Price validation (optional): Ensure price is not negative
  validates :price, numericality: { greater_than_or_equal_to: 0 }

end
