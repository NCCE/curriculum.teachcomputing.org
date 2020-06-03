class CreateAssessments < ActiveRecord::Migration[6.0]
  def change
    create_table :assessments do |t|
      t.string :title
      t.text :description
      t.references :unit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
