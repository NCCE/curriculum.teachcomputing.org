class CreateLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :lessons, id: :uuid do |t|
      t.string :title
      t.text :description
      t.belongs_to :unit, type: :uuid, null: false, index: true

      t.timestamps
    end
  end
end
