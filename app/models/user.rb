class User < ApplicationRecord
  # Include default devise modules. Others available are:
  has_many :posts, dependent: :destroy
  has_one :seller_profile  # Add this line to associate with SellerProfile

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20] # Generate random password
    end
  end
end
