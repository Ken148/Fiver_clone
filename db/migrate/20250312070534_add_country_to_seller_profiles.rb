class AddCountryToSellerProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :seller_profiles, :country, :string
  end
end
