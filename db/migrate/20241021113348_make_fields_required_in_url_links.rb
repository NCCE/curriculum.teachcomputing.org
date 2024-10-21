class MakeFieldsRequiredInUrlLinks < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:url_links, :label, false)
    change_column_null(:url_links, :url, false)
  end
end
