class AddUserIdToSellerProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :seller_profiles, :user_id, :integer
    add_index :seller_profiles, :user_id  # Adds index for faster queries
  end
end
