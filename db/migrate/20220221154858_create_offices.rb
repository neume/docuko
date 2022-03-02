class CreateOffices < ActiveRecord::Migration[6.1]
  def change
    create_table :offices do |t|
      t.string :name
      t.string :slug
      t.bigint :created_by_id, null: false
      t.text :description

      t.timestamps
    end

    add_index :offices, :created_by_id
  end
end
