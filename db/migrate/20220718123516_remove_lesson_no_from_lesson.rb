class RemoveLessonNoFromLesson < ActiveRecord::Migration[6.1]
  def change
    remove_column :lessons, :lesson_no
  end
end
