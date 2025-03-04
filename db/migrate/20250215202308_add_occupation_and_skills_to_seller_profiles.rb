class AddOccupationAndSkillsToSellerProfiles < ActiveRecord::Migration[7.0]  # Or the correct version of your Rails
  def change
    add_column :seller_profiles, :occupation, :string
    add_column :seller_profiles, :skills, :text  # Using :text for skills in case you need more space
    add_column :seller_profiles, :education, :string
    add_column :seller_profiles, :certifications, :string
    add_column :seller_profiles, :personal_website, :string
  end
end
