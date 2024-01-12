class CreateNationalCurriculumStatementUnits < ActiveRecord::Migration[6.1]
  def change
    create_table :national_curriculum_statements_units, id: :uuid do |t|
      t.references :national_curriculum_statement, null: false, foreign_key: true, type: :uuid, index: {name: "index_on_statement_id"}
      t.references :unit, null: false, foreign_key: true, type: :uuid, index: {name: "index_on_unit_id"}

      t.timestamps
    end
  end
end
