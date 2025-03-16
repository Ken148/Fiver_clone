class SellerProfile < ApplicationRecord
  belongs_to :user
  belongs_to :post  # Ensures that each SellerProfile belongs to a Post

  has_many :educations, dependent: :destroy
  has_many :gigs, dependent: :destroy
  
  has_one_attached :profile_picture

  validates :user, presence: true
  validates :full_name, :display_name, :description, :language, presence: true
  validates :profile_picture, presence: true, on: :create

  validates :occupation, :skills, presence: true, if: -> { persisted? }

  validate :check_profile_picture_format
  validate :check_occupation_and_skills, unless: -> { new_record? }
  validate :check_for_gigs, on: :update, if: -> { occupation.present? && skills.present? }
  validate :check_for_post, on: :update

  private

  def check_occupation_and_skills
    if occupation.blank? || skills.blank?
      errors.add(:base, "Occupation and skills must be provided when updating the profile")
    end
  end

  def check_profile_picture_format
    if profile_picture.attached? && !profile_picture.content_type.in?(%w[image/jpeg image/png])
      errors.add(:profile_picture, 'must be a JPEG or PNG')
    end
  end

  def check_for_gigs
    if gigs.empty?
      errors.add(:base, "You must create at least one gig before completing the profile")
    end
  end

  def check_for_post
    if post.nil?
      errors.add(:base, "You must create a post before completing the profile")
    end
  end
end
