class RemoveObjectivesFromLessons < ActiveRecord::Migration[6.1]
  def change
    remove_column :lessons, :objectives, :text
  end
end
