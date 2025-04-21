class MakeGigIdOptionalInPosts < ActiveRecord::Migration[6.1]
  def change
    change_column_null :posts, :gig_id, true
  end
end
