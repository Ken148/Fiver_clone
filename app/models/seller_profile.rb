class SellerProfile < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :educations, dependent: :destroy
  has_many :gigs, dependent: :destroy

  # ActiveStorage attachment for profile picture
  has_one_attached :profile_picture

  # Validations for required fields
  validates :user, presence: true
  validates :full_name, :display_name, :description, :language, presence: true
  validates :profile_picture, presence: true, on: :create

  # Ensure occupation and skills exist when updating the profile
  validates :occupation, :skills, presence: true, if: -> { persisted? }

  # Custom validations
  validate :check_profile_picture_format
  validate :check_occupation_and_skills, unless: -> { new_record? }

  private

  # Ensure occupation and skills are provided when updating the profile
  def check_occupation_and_skills
    if occupation.blank? || skills.blank?
      errors.add(:base, "Occupation and skills must be provided when updating the profile")
    end
  end

  # Validate profile picture format
  def check_profile_picture_format
    if profile_picture.attached? && !profile_picture.content_type.in?(%w[image/jpeg image/png])
      errors.add(:profile_picture, 'must be a JPEG or PNG')
    end
  end
end
