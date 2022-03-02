class CreateInstances < ActiveRecord::Migration[6.1]
  def change
    create_table :instances do |t|
      t.bigint :created_by_id, index: true
      t.bigint :data_model_id, index: true
      t.string :data_model_name

      t.timestamps
    end
  end
end
