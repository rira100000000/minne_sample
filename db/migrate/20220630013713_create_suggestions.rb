class CreateSuggestions < ActiveRecord::Migration[6.0]
  def change
    create_table :suggestions do |t|
      t.text :title
      t.text :body
      t.integer :order_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
