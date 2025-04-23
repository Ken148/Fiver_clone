# app/models/post.rb
class Post < ApplicationRecord
  # A Post belongs to a user (creator of the category)
  belongs_to :user

  # A Post has many services (the services offered under this category)
  has_many :services, dependent: :destroy

  # A Post can have many orders through the services (if orders are related to services)
  has_many :orders, through: :services

  # A Post can have many reviews (if relevant for the services under this category)
  has_many :reviews, dependent: :destroy

  # A Post can have one attached image (to represent the category visually)
  has_one_attached :image

  # Validations to ensure title and content are present when creating a Post
  validates :title, :content, presence: true
end
