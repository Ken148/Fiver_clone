class AddForeignKeyToPosts < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :posts, :gigs
  end
end
