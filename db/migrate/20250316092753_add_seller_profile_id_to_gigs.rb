class AddSellerProfileIdToGigs < ActiveRecord::Migration[8.0]
  def change
    add_column :gigs, :seller_profile_id, :integer
  end
end
