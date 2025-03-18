class Post < ApplicationRecord
  belongs_to :gig
  belongs_to :user
  has_many :orders  # Orders belong to posts

  validates :title, :content, :gig, presence: true
end
