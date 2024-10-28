class CreateUrlLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :url_links, id: :uuid do |t|
      t.string :label, null: false
      t.string :url, null: false
      t.string :type_descriptor, null: true
      t.references :unit, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
