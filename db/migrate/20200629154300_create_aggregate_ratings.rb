class CreateAggregateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :aggregate_ratings, id: :uuid do |t|
      t.integer :total_positive, null: false, default: 0
      t.integer :total_negative, null: false, default: 0

      t.timestamps
    end
  end
end
