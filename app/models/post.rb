class Post < ApplicationRecord
  belongs_to :gig
  belongs_to :user
  validates :title, :content, presence: true
end
