class CreateDataModels < ActiveRecord::Migration[6.1]
  def change
    create_table :data_models do |t|
      t.bigint :created_by_id, index: true
      t.bigint :office_id, index: true
      t.string :name, null: false
      t.text :description

      t.timestamps
    end
  end
end
