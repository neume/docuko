class CreateTemplates < ActiveRecord::Migration[6.1]
  def change
    create_table :templates do |t|
      t.string :name
      t.bigint :office_id, index: true, foreign_key: true
      t.text :description
      t.bigint :data_model_id, index: true, foreing_key: true

      t.timestamps
    end
  end
end
