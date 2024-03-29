class CreateOrderTags < ActiveRecord::Migration[6.0]
  def change
    create_table :order_tags do |t|
      t.references :order, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
    # 同じタグを２回保存するのは出来ないようになる
    add_index :order_tags, [:order_id, :tag_id], unique: true
  end
end
