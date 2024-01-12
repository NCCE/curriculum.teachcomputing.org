class CreateConnectedWorldStrands < ActiveRecord::Migration[6.1]
  def change
    create_table :connected_world_strands, id: :uuid do |t|
      t.string :strand
      t.text :description

      t.timestamps
    end

    create_table :connected_world_strands_units, id: false do |t|
      t.references :connected_world_strand, null: false, foreign_key: true, type: :uuid, index: {name: "index_on_strand_id"}
      t.references :unit, null: false, foreign_key: true, type: :uuid, index: {name: "index_strand_on_unit_id"}
    end
  end
end
