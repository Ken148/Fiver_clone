class AddWebsiteToSellerProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :seller_profiles, :website, :string
  end
end
