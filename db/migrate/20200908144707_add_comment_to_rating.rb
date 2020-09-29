class AddCommentToRating < ActiveRecord::Migration[6.0]
  def change
    add_column :ratings, :comment, :text
  end
end
