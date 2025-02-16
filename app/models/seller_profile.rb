class SellerProfile < ApplicationRecord
    # Ensure validations for required fields
    validates :full_name, :display_name, :description, :language, presence: true
    validates :occupation, :skills, presence: true # Required fields
  end
  