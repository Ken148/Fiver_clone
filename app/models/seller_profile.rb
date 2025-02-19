class SellerProfile < ApplicationRecord
  # Association with the User model
  belongs_to :user  # This defines the relationship between the seller profile and user

  # Ensure that a user is present when creating a seller profile
  validates :user, presence: true  # This ensures that the user association is not null

  # Ensure validations for required fields in the correct step
  validates :full_name, :display_name, :description, :language, presence: true, on: :create

  # Validate occupation and skills only when updating the profile
  validates :occupation, :skills, presence: true, on: :update

  # Optional: Ensure that occupation and skills only exist when the profile is being updated (not during creation)
  # So, you can validate presence only during the update process
  validate :check_occupation_and_skills, on: :update

  # Optional: If you want to validate other fields, you can do it here
  validate :check_profile_picture_format, if: :profile_picture_attached?

  # For attaching a profile picture (use CarrierWave or ActiveStorage depending on your implementation)
  # You can add custom validations like file size or file type if needed
  def check_profile_picture_format
    if profile_picture.attached? && !profile_picture.content_type.in?(%w[image/jpeg image/png])
      errors.add(:profile_picture, 'must be a JPEG or PNG')
    end
  end

  # Optional: Additional validation for skills or other fields
  def check_occupation_and_skills
    if occupation.blank? || skills.blank?
      errors.add(:occupation, "Occupation and skills must be provided when updating the profile")
    end
  end
end
