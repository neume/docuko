class CreateModelProperties < ActiveRecord::Migration[6.1]
  def change
    create_table :model_properties do |t|
      t.bigint :data_model_id, index: true
      t.text :name
      t.text :default_value
      t.integer :property_type, default: 0
      t.boolean :required, default: false
      t.string :code
      t.text :description
      t.boolean :header_visibility
      t.integer :position, default: 0

      t.timestamps
    end
  end
end
