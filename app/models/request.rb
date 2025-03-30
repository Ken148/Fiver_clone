class Request < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # Validations to ensure data integrity
  validates :message, presence: true
  validates :price_range, presence: true

  # Optional: Add additional logic or methods if necessary
  has_many :messages, dependent: :destroy
end
