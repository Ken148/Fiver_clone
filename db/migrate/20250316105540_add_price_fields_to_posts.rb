class AddPriceFieldsToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :basic_price, :decimal
    add_column :posts, :standard_price, :decimal
    add_column :posts, :premium_price, :decimal
  end
end
