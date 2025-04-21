class Post < ApplicationRecord
  belongs_to :gig, optional: true
  belongs_to :user
  has_many :orders
  has_many :reviews, dependent: :destroy
  has_one_attached :image

  # ✅ Remove :gig from the validation line:
  validates :title, :content, presence: true
end
