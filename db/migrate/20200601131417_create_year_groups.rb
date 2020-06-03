class CreateYearGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :year_groups do |t|
      t.string :title
      t.text :description
      t.references :key_stage, null: false, foreign_key: true

      t.timestamps
    end
  end
end
