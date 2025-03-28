class Post < ApplicationRecord
  belongs_to :gig
  belongs_to :user
  has_many :orders
  has_many :reviews, dependent: :destroy  # Add this line for the reviews association

  validates :title, :content, :gig, presence: true
end
