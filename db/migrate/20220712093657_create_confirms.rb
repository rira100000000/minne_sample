class CreateConfirms < ActiveRecord::Migration[6.0]
  def change
    create_table :confirms do |t|
      t.references :order, null: false, foreign_key: true
      t.references :suggestion, null: false, foreign_key: true

      t.timestamps
    end
  end
end
