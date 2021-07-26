class CreateTaxonomyTags < ActiveRecord::Migration[6.1]
  def change
    create_table :taxonomy_tags, id: :uuid do |t|
      t.string :strand, null: false
      t.string :abbreviation, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
