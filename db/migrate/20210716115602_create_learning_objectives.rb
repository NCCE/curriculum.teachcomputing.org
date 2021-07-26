class CreateLearningObjectives < ActiveRecord::Migration[6.1]
  def change
    create_table :learning_objectives, id: :uuid do |t|
      t.text :description, null: false
      t.belongs_to :lesson, type: :uuid, null: false, index: true

      t.timestamps
    end
  end
end
