class CreateEducations < ActiveRecord::Migration[8.0]
  def change
    create_table :educations do |t|
      t.references :seller_profile, null: false, foreign_key: true
      t.string :degree
      t.string :school_name
      t.integer :graduation_year

      t.timestamps
    end
  end
end
