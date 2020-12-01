class AddCurriculumMapTable < ActiveRecord::Migration[6.0]
  def change
    create_table :curriculum_maps, id: :uuid do |t|
      t.string :name
      t.belongs_to :key_stage, type: :uuid, null: false, index: true

      t.timestamps
    end
  end
end
