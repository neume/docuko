class AddAttributesToInstanceProperties < ActiveRecord::Migration[6.1]
  def change
    rename_column :instance_properties, :field_name, :name
    add_column :instance_properties, :required, :boolean, default: false
    add_column :instance_properties, :position, :integer, default: 0
    add_column :instance_properties, :default_value, :text
  end
end
