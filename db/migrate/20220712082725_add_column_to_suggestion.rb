class AddColumnToSuggestion < ActiveRecord::Migration[6.0]
  def change
    add_column :suggestions, :price, :integer, null: false
    add_column :suggestions, :deadline, :integer, null: false
  end
end
