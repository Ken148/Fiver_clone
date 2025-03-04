class SellerProfile < ApplicationRecord
  # Association with the User model
  belongs_to :user  # This defines the relationship between the seller profile and user

  # Association with the Education model
  has_many :educations  # A seller profile has many educations

  # Ensure that a user is present when creating a seller profile
  validates :user, presence: true  # This ensures that the user association is not null

  # Ensure validations for required fields in the correct step
  validates :full_name, :display_name, :description, :language, presence: true, on: :create

  # Validate occupation and skills only when updating the profile
  validates :occupation, :skills, presence: true, on: :update

  # Optional: Ensure that occupation and skills only exist when the profile is being updated (not during creation)
  validate :check_occupation_and_skills, on: :update

  # Attach a profile picture (ActiveStorage)
  has_one_attached :profile_picture

  # Validate presence of the profile picture only when creating the profile
  validates :profile_picture, presence: true, on: :create

  # Validate file format for the profile picture (JPEG or PNG)
  validate :check_profile_picture_format, if: :profile_picture_attached?

  # Validate the new gig fields (optional)
  validates :gig_title, :gig_description, :gig_price, presence: true, on: :create_gig

  # Optional: Additional validation for skills or other fields
  def check_occupation_and_skills
    if occupation.blank? || skills.blank?
      errors.add(:occupation, "Occupation and skills must be provided when updating the profile")
    end
  end

  # Validate the profile picture file type (JPEG or PNG)
  def check_profile_picture_format
    if profile_picture.attached? && !profile_picture.content_type.in?(%w[image/jpeg image/png])
      errors.add(:profile_picture, 'must be a JPEG or PNG')
    end
  end

  private

  # Helper method to check if profile picture is attached
  def profile_picture_attached?
    profile_picture.attached?
  end
end
