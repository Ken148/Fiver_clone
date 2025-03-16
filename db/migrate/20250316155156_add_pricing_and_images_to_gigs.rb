class AddPricingAndImagesToGigs < ActiveRecord::Migration[8.0]
  def change
    add_column :gigs, :basic_price, :decimal, null: false, default: 0
    add_column :gigs, :standard_price, :decimal, null: false, default: 0
    add_column :gigs, :premium_price, :decimal, null: false, default: 0

    add_column :gigs, :basic_description, :text
    add_column :gigs, :standard_description, :text
    add_column :gigs, :premium_description, :text

    add_column :gigs, :basic_image, :string
    add_column :gigs, :standard_image, :string
    add_column :gigs, :premium_image, :string

    # Uncomment this if using ActiveStorage
    add_attachment :gigs, :basic_image
    add_attachment :gigs, :standard_image
    add_attachment :gigs, :premium_image
  end
end
