class AddUniqueIndexForSlugandUnitIdOnLesson < ActiveRecord::Migration[6.0]
  def change
    add_index :lessons, [:slug, :unit_id], unique: true
  end
end
