class CreateRedirects < ActiveRecord::Migration[6.1]
  def change
    create_table :redirects, id: :uuid, force: :cascade do |t|
      t.string "redirectable_type", null: false
      t.uuid "redirectable_id", null: false
      t.string :from
      t.string :to
      t.timestamps
    end
  end
end
