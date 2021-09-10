class AddOrderToLearningObjectives < ActiveRecord::Migration[6.1]
  def change
    add_column :learning_objectives, :order, :integer, null: true
    # add_index :learning_objectives, [ :lesson_id, :order ], unique: true
  end
end
