class Review < ApplicationRecord
  belongs_to :post
  belongs_to :user

  # Optionally, add validations
  validates :comment, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5 }
end
