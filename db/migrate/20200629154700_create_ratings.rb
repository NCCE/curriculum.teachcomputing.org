class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings, id: :uuid do |t|
      t.references :aggregate_rating, type: :uuid, null: false, foreign_key: true
      t.boolean :positive, null: false

      t.timestamps
    end
  end
end
