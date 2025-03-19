class SellerProfile < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :educations, dependent: :destroy
  has_many :gigs, dependent: :destroy  # A seller profile can have many gigs

  # ActiveStorage attachment for profile picture
  has_one_attached :profile_picture

  # Validations for required fields
  validates :user, presence: true
  validates :full_name, :display_name, :description, :language, presence: true

  # Profile picture validation - only required on create
  validates :profile_picture, presence: true, on: :create 

  # Ensure occupation and skills exist when updating the profile
  validates :occupation, :skills, presence: true, if: :persisted?

  # Custom validations
  validate :check_profile_picture, if: -> { profile_picture.attached? }
  validate :check_occupation_and_skills, if: :persisted?

  private

  # Ensure occupation and skills are provided when updating the profile
  def check_occupation_and_skills
    if occupation.blank?
      errors.add(:occupation, "must be provided when updating the profile")
    end
    if skills.blank?
      errors.add(:skills, "must be provided when updating the profile")
    end
  end

  # Validate profile picture format and size in one method
  def check_profile_picture
    allowed_formats = %w[image/jpeg image/png]
    max_size = 5.megabytes

    # Check format
    unless profile_picture.content_type.in?(allowed_formats)
      errors.add(:profile_picture, 'must be a JPEG or PNG')
    end

    # Check size
    if profile_picture.byte_size > max_size
      errors.add(:profile_picture, "must be less than #{max_size / 1.megabyte} MB")
    end
  end
end
