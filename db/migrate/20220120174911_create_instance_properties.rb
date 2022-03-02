class CreateInstanceProperties < ActiveRecord::Migration[6.1]
  def change
    create_table :instance_properties do |t|
      t.string :field_name
      t.string :code
      t.string :value
      t.bigint :instance_id, null: false, foreign_key: true, index: true
      t.bigint :model_property_id, foreign_key: true, index:true

      t.timestamps
    end
  end
end
