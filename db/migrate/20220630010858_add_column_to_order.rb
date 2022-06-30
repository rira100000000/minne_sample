class AddColumnToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :reciever, :string
  end
end
