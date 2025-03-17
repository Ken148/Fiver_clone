class AddForeignKeyToPosts < ActiveRecord::Migration[6.0]
  def change
    # First, add the gig_id column if it's missing
    add_column :posts, :gig_id, :integer, null: false

    # Then, add the foreign key constraint
    add_foreign_key :posts, :gigs
  end
end
