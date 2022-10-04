class AddOrderToUnit < ActiveRecord::Migration[6.1]
  def change
    add_column :units, :order, :integer, null: true
  end
end
