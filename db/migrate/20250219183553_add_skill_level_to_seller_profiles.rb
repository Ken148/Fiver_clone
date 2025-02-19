class AddSkillLevelToSellerProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :seller_profiles, :skill_level, :string
  end
end
