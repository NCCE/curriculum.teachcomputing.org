class CreateKeyStages < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'pgcrypto'

    create_table :key_stages, id: :uuid do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
