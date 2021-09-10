class AddOrderToLearningObjectives < ActiveRecord::Migration[6.1]
  def change
    add_column :learning_objectives, :order, :integer, null: true
  end
end
