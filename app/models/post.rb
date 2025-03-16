class Post < ApplicationRecord
  belongs_to :user
  belongs_to :gig, optional: true # If a post is linked to a gig, it's optional.

  validates :title, :content, presence: true
end
