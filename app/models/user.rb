class User < ApplicationRecord
  # Associations
  has_many :orders
  has_many :posts, dependent: :destroy
  has_one :seller_profile, dependent: :destroy  # Ensure the seller profile is destroyed when the user is deleted

  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  # Omniauth method to find or create a user from Google OAuth2 data
  def self.from_omniauth(auth)
    # Search for an existing user by provider and UID
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      # Assign user data from the Google auth hash
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]  # Generate a random password for the user

      # Assign additional information from the OAuth response (like name, etc.)
      user.name = auth.info.name   # If you want to store the user's name
      user.image_url = auth.info.image # Store the user's profile image URL, if needed
    end
  end
end
