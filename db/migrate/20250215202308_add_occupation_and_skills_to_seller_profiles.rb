class AddOccupationAndSkillsToSellerProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :seller_profiles, :occupation, :string
    add_column :seller_profiles, :skills, :string
    add_column :seller_profiles, :education, :string
    add_column :seller_profiles, :certifications, :string
    add_column :seller_profiles, :personal_website, :string
  end
end
