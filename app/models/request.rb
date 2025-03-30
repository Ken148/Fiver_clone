class Request < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # Validations to ensure data integrity
  validates :price_range, presence: true
  validates :message, presence: true, on: :create # Validate message only on creation

  # Optional: Add additional logic or methods if necessary
  has_many :messages, dependent: :destroy
end
