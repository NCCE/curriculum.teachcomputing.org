class CreateStates < ActiveRecord::Migration[6.0]
  def change
    create_table :states, id: :uuid do |t|
      t.integer :state, null: false, default: 0

      t.timestamps
    end
  end
end
