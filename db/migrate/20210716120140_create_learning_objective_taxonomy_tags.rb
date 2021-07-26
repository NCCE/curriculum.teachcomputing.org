class CreateLearningObjectiveTaxonomyTags < ActiveRecord::Migration[6.1]
  def change
    create_table :learning_objectives_taxonomy_tags, id: :uuid do |t|
      t.references :taxonomy_tag, null: false, foreign_key: true, type: :uuid,
                                  index: { name: 'index_on_taxonomy_tag_id' }
      t.references :learning_objective, null: false, foreign_key: true, type: :uuid,
                                        index: { name: 'index_on_learning_objective_id' }

      t.timestamps
    end
  end
end
