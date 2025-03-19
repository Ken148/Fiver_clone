class Post < ApplicationRecord
  belongs_to :gig
  belongs_to :user
  
  validates :title, :content, :gig, presence: true
end
