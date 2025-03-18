class AddPricingAndImagesToGigs < ActiveRecord::Migration[8.0]
  def change
    # Add pricing columns for Basic, Standard, and Premium
    add_column :gigs, :basic_price, :decimal, null: false, default: 0
    add_column :gigs, :standard_price, :decimal, null: false, default: 0
    add_column :gigs, :premium_price, :decimal, null: false, default: 0

    # Add description columns for Basic, Standard, and Premium
    add_column :gigs, :basic_description, :text
    add_column :gigs, :standard_description, :text
    add_column :gigs, :premium_description, :text

    # Add ActiveStorage support for images
    add_attachment :gigs, :basic_image
    add_attachment :gigs, :standard_image
    add_attachment :gigs, :premium_image
  end
end
