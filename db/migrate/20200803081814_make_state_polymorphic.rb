class MakeStatePolymorphic < ActiveRecord::Migration[6.0]
  def up
    # stateable: KeyStages, Lessons, Units, YearGroups

    # add poly columns to state table
    add_column :states, :stateable_id, :uuid
    add_column :states, :stateable_type, :string

    # update values in state table for linked records
    update_lesson_state = <<~QUERY
      UPDATE
        states s
      SET
        stateable_id = l.id,
        stateable_type = 'Lesson'
      FROM
        lessons l
      WHERE
        s.id = l.state_id;
    QUERY
    execute update_lesson_state

    update_unit_state = <<~QUERY
      UPDATE
        states s
      SET
        stateable_id = u.id,
        stateable_type = 'Unit'
      FROM
        units u
      WHERE
        s.id = u.state_id;
    QUERY
    execute update_unit_state

    update_year_group_state = <<~QUERY
      UPDATE
        states s
      SET
        stateable_id = y.id,
        stateable_type = 'YearGroup'
      FROM
        year_groups y
      WHERE
        s.id = y.state_id;
    QUERY
    execute update_year_group_state

    update_key_stage_state = <<~QUERY
      UPDATE
        states s
      SET
        stateable_id = k.id,
        stateable_type = 'KeyStage'
      FROM
        key_stages k
      WHERE
        s.id = k.state_id;
    QUERY
    execute update_key_stage_state

    # remove columns from publishable tables
    remove_column :lessons, :state_id
    remove_column :units, :state_id
    remove_column :year_groups, :state_id
    remove_column :key_stages, :state_id
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
