class MakeAggregateRatingsPolymorphic < ActiveRecord::Migration[6.0]
  def up
    # rateable: Unit, Lesson

    # add poly columns to agg ratings table
    add_column :aggregate_ratings, :rateable_id, :uuid
    add_column :aggregate_ratings, :rateable_type, :string

    # update values for in agg table linking records correctly
    update_unit_aggregate_ratings = <<~QUERY
      UPDATE
        aggregate_ratings ag
      SET
        rateable_id = u.id,
        rateable_type = 'Unit'
      FROM
        units u
      WHERE
        ag.id = u.aggregate_rating_id;
    QUERY
    execute update_unit_aggregate_ratings

    update_lesson_aggregate_ratings = <<~QUERY
      UPDATE
        aggregate_ratings ag
      SET
        rateable_id = l.id,
        rateable_type = 'Lesson'
      FROM
        lessons l
      WHERE
        ag.id = l.aggregate_rating_id;
    QUERY
    execute update_lesson_aggregate_ratings

    # remove column from rateable tables
    remove_column :units, :aggregate_rating_id
    remove_column :lessons, :aggregate_rating_id
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
