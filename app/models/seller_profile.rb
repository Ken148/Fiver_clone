class SellerProfile < ApplicationRecord
  # Ensure validations for required fields in the correct step
  validates :full_name, :display_name, :description, :language, presence: true
  validates :occupation, :skills, presence: true, on: :update  # Only validate when updating
end
