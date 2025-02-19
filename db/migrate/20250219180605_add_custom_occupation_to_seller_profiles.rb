class AddCustomOccupationToSellerProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :seller_profiles, :custom_occupation, :string
  end
end
