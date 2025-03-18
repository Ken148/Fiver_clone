class Order < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :message, presence: true
  validates :price_range, presence: true
end
