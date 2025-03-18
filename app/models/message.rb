class Message < ApplicationRecord
  belongs_to :post
  belongs_to :user

  # Ensure content is a permitted field
  validates :content, presence: true
  validates :price_range, presence: true
end
