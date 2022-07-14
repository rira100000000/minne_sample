class AddColumnToConfirm < ActiveRecord::Migration[6.0]
  def change
    add_column :confirms, :address, :string
    add_column :confirms, :tel, :string
    add_column :confirms, :receiver_name, :string
    add_column :confirms, :postcode, :string
  end
end
