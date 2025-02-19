class AddStartYearAndEndYearToSellerProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :seller_profiles, :start_year, :integer
    add_column :seller_profiles, :end_year, :integer
  end
end
