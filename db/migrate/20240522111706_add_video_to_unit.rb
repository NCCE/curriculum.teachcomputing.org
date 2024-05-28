class AddVideoToUnit < ActiveRecord::Migration[6.1]
  def change
    add_reference :units, :video, foreign_key: true, type: :uuid
  end
end
