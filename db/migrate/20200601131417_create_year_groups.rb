class CreateYearGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :year_groups, id: :uuid do |t|
      t.string :title
      t.text :description
      t.belongs_to :key_stage, type: :uuid, null: false, index: true

      t.timestamps
    end
  end
end
