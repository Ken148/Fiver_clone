class CreateSellerProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :seller_profiles do |t|
      t.string :full_name
      t.string :display_name
      t.string :profile_picture
      t.text :description
      t.string :language

      t.timestamps
    end
  end
end
