class AddCountryCodeToSellerProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :seller_profiles, :country_code, :string
  end
end
