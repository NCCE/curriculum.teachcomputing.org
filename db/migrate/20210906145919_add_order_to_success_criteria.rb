class AddOrderToSuccessCriteria < ActiveRecord::Migration[6.1]
  def change
    add_column :success_criteria, :order, :integer, null: true
  end
end
