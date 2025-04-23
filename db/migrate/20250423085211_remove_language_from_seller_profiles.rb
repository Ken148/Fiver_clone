class RemoveLanguageFromSellerProfiles < ActiveRecord::Migration[6.1]
  def change
    remove_column :seller_profiles, :language, :string
  end
end
