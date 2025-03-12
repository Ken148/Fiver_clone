class RemoveSchoolNameFromSellerProfiles < ActiveRecord::Migration[8.0]
  def change
    remove_column :seller_profiles, :school_name, :string
  end
end
