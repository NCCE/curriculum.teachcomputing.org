class AddVideoToLesson < ActiveRecord::Migration[6.1]
  def change
    add_reference :lessons, :video, foreign_key: true, type: :uuid
  end
end
