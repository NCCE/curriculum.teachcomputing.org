class CreateUrlLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :url_links, id: :uuid do |t|
      t.string :label
      t.string :url
      t.references :unit, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
