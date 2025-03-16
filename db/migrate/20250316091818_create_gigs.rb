class CreateGigs < ActiveRecord::Migration[8.0]
  def change
    create_table :gigs do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
