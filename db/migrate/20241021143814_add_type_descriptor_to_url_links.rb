class AddTypeDescriptorToUrlLinks < ActiveRecord::Migration[6.1]
  def change
    add_column :url_links, :type_descriptor, :string, null: true
  end
end
