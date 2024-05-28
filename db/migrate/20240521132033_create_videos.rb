class CreateVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :videos, id: :uuid do |t|
      t.string :title, null: false
      t.string :name
      t.string :job_title
      t.text :description
      t.string :video_url, null: false

      t.timestamps
    end
  end
end
