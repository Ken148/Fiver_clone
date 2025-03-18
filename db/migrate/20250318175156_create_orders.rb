class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.references :post, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :status
      t.text :customer_message
      t.text :creator_reply

      t.timestamps
    end
  end
end
