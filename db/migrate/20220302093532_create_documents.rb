class CreateDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :documents do |t|
      t.bigint :created_by_id
      t.bigint :template_id
      t.bigint :instance_id
      t.string :version
      t.string :name
      t.text :context

      t.timestamps
    end
    add_index :documents, :created_by_id
    add_index :documents, :template_id
    add_index :documents, :data_model_id
  end
end
