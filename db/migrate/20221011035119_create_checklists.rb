class CreateChecklists < ActiveRecord::Migration[6.0]
  def change
    create_table :checklists do |t|
      t.boolean :order_id
      t.boolean :order_day
      t.boolean :order_status
      t.boolean :payment_type
      t.boolean :payment_day
      t.boolean :send_day
      t.boolean :item_name
      t.boolean :send_type
      t.boolean :send_area
      t.boolean :dead_line
      t.boolean :item_price
      t.boolean :quantity
      t.boolean :item_total_price
      t.boolean :note
      t.boolean :total_price
      t.boolean :send_price
      t.boolean :all_total_price
      t.boolean :user_id
      t.boolean :nickname
      t.boolean :use_name
      t.boolean :user_tel
      t.boolean :post_number
      t.boolean :address1
      t.boolean :address2
      t.boolean :sending_name
      t.boolean :sending_tel
      t.boolean :item_id

      t.timestamps
    end
  end
end
