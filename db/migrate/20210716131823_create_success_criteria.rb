class CreateSuccessCriteria < ActiveRecord::Migration[6.1]
  def change
    create_table :success_criteria, id: :uuid do |t|
      t.string :description, null: false
      t.belongs_to :learning_objective, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
