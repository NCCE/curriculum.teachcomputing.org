class AddLessonNoToLessonModel < ActiveRecord::Migration[6.0]
  def change
    add_column :lessons, :lesson_no, :integer, default: 0
  end
end
