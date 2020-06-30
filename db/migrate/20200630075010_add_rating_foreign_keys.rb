class AddRatingForeignKeys < ActiveRecord::Migration[6.0]
  def change
    add_column :lessons, :aggregate_rating_id, :uuid
    add_foreign_key :lessons, :aggregate_ratings

    add_column :units, :aggregate_rating_id, :uuid
    add_foreign_key :units, :aggregate_ratings
  end
end
