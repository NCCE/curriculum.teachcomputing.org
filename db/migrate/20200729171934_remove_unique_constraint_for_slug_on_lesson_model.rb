class RemoveUniqueConstraintForSlugOnLessonModel < ActiveRecord::Migration[6.0]
  def change
    remove_index :lessons, :slug
  end
end
