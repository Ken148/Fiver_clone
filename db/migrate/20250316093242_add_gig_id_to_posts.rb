class AddGigIdToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :gig_id, :integer
  end
end
