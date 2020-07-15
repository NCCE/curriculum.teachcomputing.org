class AddLessonObjectivesToLessonModel < ActiveRecord::Migration[6.0]
  def change
    add_column :lessons, :objectives, :text
  end
end
