class CreateUnits < ActiveRecord::Migration[6.0]
  def change
    create_table :units, id: :uuid do |t|
      t.string :title
      t.text :description
      t.belongs_to :year_group, type: :uuid, null: false, index: true

      t.timestamps
    end
  end
end
