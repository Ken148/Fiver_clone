class CreateEducations < ActiveRecord::Migration[8.0]
  def change
    create_table :educations do |t|
      t.string :school_name
      t.string :degree
      t.string :field_of_study
      t.integer :user_id

      t.timestamps
    end

    # Add foreign key constraint after creating the table
    add_foreign_key :educations, :users, column: :user_id
  end
end
