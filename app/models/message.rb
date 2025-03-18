class Message < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :content, presence: true
  validates :price_range, presence: true
end
