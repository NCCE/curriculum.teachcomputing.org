class AddOrderToSuccessCriteria < ActiveRecord::Migration[6.1]
  def change
    add_column :success_criteria, :order, :integer, null: true
    # add_index :success_criteria, [ :learning_objective_id, :order ], unique: true
  end
end
