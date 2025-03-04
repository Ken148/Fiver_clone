class AddDetailsToEducations < ActiveRecord::Migration[8.0]
  def change
    add_column :educations, :new_column_name, :string
  end
end
