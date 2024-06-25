class MakeFieldsRequiredInVideos < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:videos, :name, false)
    change_column_null(:videos, :job_title, false)
    change_column_null(:videos, :description, false)
  end
end
