class RemoveMessageFromMessages < ActiveRecord::Migration[8.0]
  def change
    remove_column :messages, :message, :text
  end
end
