class AddEmailAndPhoneNumberToSellerProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :seller_profiles, :email, :string
    add_column :seller_profiles, :phone_number, :string
  end
end
