class AddGigFieldsToSellerProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :seller_profiles, :gig_title, :string
    add_column :seller_profiles, :gig_description, :text
    add_column :seller_profiles, :gig_price, :decimal
  end
end
