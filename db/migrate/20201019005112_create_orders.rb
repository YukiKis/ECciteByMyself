class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.string :deliver_postcode, null: false
      t.string :deliver_address, null: false
      t.string :deliver_name, null: false
      t.integer :deliver_fee, null: false, default: 800
      t.integer :total_price, null: false
      t.integer :how_to_pay, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
